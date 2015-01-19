'''
Created on Jul 4, 2014

@author: nkatz
'''

##########################################################################################
#
# This a (tweaked) version of the PyLog project (https://wiki.python.org/moin/PyLog). 
# It is experimental and NO PART OF THIS CODE IS USED ANYWHERE in this version of ILED.
# 
##########################################################################################


__version__ = "3.0-dev"

import copy
from itertools import izip
import math

###########################################################
#
# Pylog Objects
#
###########################################################

class Term:
    """ Base class for terms, variables, predicates, ...
    """

    def __init__(self, *args):
        self.args = list(args)
        self.functor = self.__class__
        self.arity = len(args)

    def __str__(self, L=10):
        if L < 0: return '...'
        args = []
        for arg in self.args:
            if isinstance(arg, Term):
                arg = arg.__str__(L-1)
            else:
                arg = str(arg)
            args.append(arg)
        return "%s(%s)"%(self.functor.__name__, ','.join(args))

    def __hash__(self):
        return id(self)

    def __and__(self, other): return And(self, other)
    def __or__(self, other): return Or(self, other)
    def __eq__(self, other): return Eq(self, other)
    def __ne__(self, other): return Ne(self, other)
    def __lt__(self, other): return Lt(self, other)
    def __le__(self, other): return Le(self, other)
    def __gt__(self, other): return Gt(self, other)
    def __ge__(self, other): return Ge(self, other)
    def __invert__(self): return Not(self)

    def __iter__(self): return self(Stack())

    def copy(self, s, memo):
        try:
            obj = memo[id(self)]
        except KeyError:
            obj = copy.copy(self)
            memo[id(self)] = obj
            memo[id(obj)] = obj
            obj.rebuild(s, memo)
        return obj

    def rebuild(self, s, memo):
        args = []
        for arg in self.args:
            if isinstance(arg, Term):
                arg = arg.copy(s, memo)
            args.append(arg)
        self.args = args

    def cmp(self, other, s):
        if isinstance(other, Term) and not isinstance(other, Var):
            o = cmp(self.arity, other.arity) or cmp(self.functor.__name__, other.functor.__name__)
            if o: return o
            for a,b in izip(self.args, other.args):
                a = s[a]
                b = s[b]
                if isinstance(a, Term): o = a.cmp(b, s)
                elif isinstance(b, Term): o = -b.cmp(a, s)
                else: o = cmp(a, b)
                if o: return o
            return 0
        else:
            return +1

class Term0(Term):
    def __init__(self): Term.__init__(self)

class Term1(Term):
    def __init__(self, a): Term.__init__(self, a)

class Term2(Term):
    def __init__(self, a, b): Term.__init__(self, a, b)

class Term3(Term):
    def __init__(self, a, b, c): Term.__init__(self, a, b, c)

class Var(Term):
    """ Variables
    """

    _n = 0

    def __init__(self, name=None):
        Term.__init__(self, name)
        Var._n += 1
        self.name = name or "_%s"%Var._n

    def __str__(self, L=None):
        return self.name

    def __hash__(self):
        return id(self)

    def copy(self, s, memo):
        try:
            obj = memo[id(self)]
        except KeyError:
            obj = s[self]
            if isinstance(obj, Var):
                memo[id(self)] = obj
            elif isinstance(obj, Term):
                obj = copy.copy(obj)
                memo[id(self)] = obj
                memo[id(obj)] = obj
                obj.rebuild(s, memo)
        return obj

    def cmp(self, other, s):
        a = s[self]
        b = s[other]
        if a is not self:
            return a.cmp(b, s)
        if isinstance(other, Var):
            return cmp(id(self), id(other))
        else:
            return -1

class cons(Term2): pass
class nil(Term0): pass
nil = nil()

###########################################################
#
# Stack of variable bindings
#
###########################################################

class Stack:
    """ Variable bindings stack

    Unification creates a new stack with one more item
    containing new bindings.
    """

    def __init__(self, parent=None):
        self.parent = parent
        self.vars = {}

    def new(self):
        return Stack(parent=self)

    def __getitem__(self, item):
        while isinstance(item, Var):
            try:
                item2 = self.vars[item]
            except KeyError, e:
                try:
                    item2 = self.parent[item]
                except TypeError:
                    return item
            if item2 is item:
                break
            item = item2
        return item

    def __setitem__(self, item, value):
        assert isinstance(item, Var)
        self.vars[item] = value

    def __call__(self, T):
        if isinstance(T, Term):
            return T.copy(self, {})
        else:
            return T

    def unify(self, T1, T2):
        u = self.new()
        if u._unify(T1, T2):
            yield u

    def unify_with_occurs_check(self, T1, T2):
        u = self.new()
        if u._unify(T1, T2, occurs_check=True):
            yield u

    def _unify(self, T1, T2, occurs_check=False):
        T1 = self[T1]
        T2 = self[T2]
        if T1 is T2: return True
        if isinstance(T1, Var):
            if isinstance(T2, Var):
                self[T1] = T2
            elif isinstance(T2, Term):
                if occurs_check and self.contains(T2, T1): return False
                self[T1] = T2
            else:
                self[T1] = T2
        elif isinstance(T1, Term):
            if isinstance(T2, Var):
                if occurs_check and self.contains(T1, T2): return False
                self[T2] = T1
            elif isinstance(T2, Term):
                if T1.functor != T2.functor: return False
                if T1.arity != T2.arity: return False
                for x, y in izip(T1.args, T2.args):
                    if not self._unify(x, y): return False
            else:
                return False
        else:
            if isinstance(T2, Var):
                self[T2] = T1
            elif isinstance(T2, Term):
                return False
            else:
                if T1 != T2:
                    return False
        return True

    def contains(self, t, v):
        seen = set()
        ts = set([t])
        while ts:
            t = self[ts.pop()]
            if t not in seen:
                seen.add(t)
                if t is v: return True
                if isinstance(t, Term) and not isinstance(t, Var):
                    for arg in t.args:
                        ts.add(arg)
        return False

###########################################################
#
# Pylog predicates
#
###########################################################

class Rec(Term):
    """ Recursive call of a predicate
    """

    def __call__(self, s):
        return self.args[0](*self.args[1:])(s)

class Not(Term1):
    """ Negation
    """

    def __call__(self, s):
        for s in self.args[0](s):
            return
        yield s

###########################################################
#
# Pylog library
#
###########################################################

# Verify Type of a Term

class IsVar(Term):
    """ IsVar(+Term)
    Succeeds if Term currently is a free variable.
    """

    def __call__(self, s):
        for v in self.args:
            if not isinstance(s[v], Var):
                break
        else:
            yield s

class IsNonVar(Term):
    """ IsNonVar(+Term)
    Succeeds if Term currently is not a free variable.
    """

    def __call__(self, s):
        for v in self.args:
            if isinstance(s[v], Var):
                break
        else:
            yield s

class IsInteger(Term):
    """ IsInteger(+Term)
    Succeeds if Term is bound to an integer.
    """

    def __call__(self, s):
        for v in self.args:
            if not isinstance(s[v], (int, long)):
                break
        else:
            yield s

class IsFloat(Term):
    """ IsFloat(+Term)
    Succeeds if Term is bound to a floating point number.
    """

    def __call__(self, s):
        for v in self.args:
            if not isinstance(s[v], float):
                break
        else:
            yield s


class IsNumber(Term):
    """ IsNumber(+Term)
    Succeeds if Term is bound to an integer or floating point number.
    """

    def __call__(self, s):
        for n in self.args:
            if not isinstance(s[n], (int, long, float)):
                break
        else:
            yield s

class IsAtom(Term):
    """ IsAtom(+Term)
    Succeeds if Term is bound to an atom.
    """

    def __call__(self, s):
        for a in self.args:
            if not isinstance(s[a], (str, int, long, float)):
                break
        else:
            yield s

class IsString(Term):
    """ IsString(+Term)
    Succeeds if Term is bound to a string.
    """
    
    def __call__(self, s):
        for st in self.args:
            if not isinstance(s[st], str):
                break
        else:
            yield s


class IsCompound(Term):
    """ IsCompound(+Term)
    Succeeds if Term is bound to a compound term. See also functor/3 and =../2.
    """

    def __call__(self, s):
        for t in self.args:
            t = s[t]
            if isinstance(t, Var) or not isinstance(t, Term):
                break
        else:
            yield s

class IsCallable(IsCompound):
    """ IsCallable(+Term)
    Succeeds if Term is bound to an atom or a compound term, so it can be handed without type-error to call/1, functor/3 and =../2.
    """

class IsGround(Term):
    """ IsGround(+Term)
    Succeeds if Term holds no free variables.
    """

    def __call__(self, s):
        for t in self.args:
            ts = set([t])
            seen = set()
            while ts:
                t = s[ts.pop()]
                if t not in seen:
                    seen.add(t)
                    if isinstance(t, Var):
                        return
                    if isinstance(t, Term):
                        for arg in t.args:
                            ts.add(arg)
        yield s

class IsCyclic(Term):
    """ IsCyclic(+Term)
    Succeeds if Term contains cycles, i.e. is an infinite term. See also acyclic_term/1 and section 2.16. (24)
    """

    def __call__(self, s):
        for t in self.args:
            seen = set()
            ts = set([t])
            while ts:
                t = s[ts.pop()]
                if t in seen:
                    break
                if isinstance(t, Term) and not isinstance(t, Var):
                    seen.add(t)
                    for arg in t.args:
                        ts.add(arg)
            else:
                return
        yield s

class IsAcyclic(Term):
    """ IsAcyclic(+Term)
    Succeeds if Term does not contain cycles, i.e. can be processed recursively in finite time. See also cyclic_term/1 and section 2.16.
    """

    def __call__(self, s):
        for t in self.args:
            seen = set()
            ts = set([t])
            while ts:
                t = s[ts.pop()]
                if t in seen:
                    return
                if isinstance(t, Term) and not isinstance(t, Var):
                    seen.add(t)
                    for arg in t.args:
                        ts.add(arg)
        yield s

# Comparison and Unification or Terms

# Standard Order of Terms
#
#Comparison and unification of arbitrary terms. Terms are ordered in the so called ``standard order''. This order is defined as follows:
#
#   1. Variables < Atoms < Strings < Numbers < Terms (25)
#   2. Variables are sorted by address. Attaching attributes (see section 6.1) does not affect the ordering.
#   3. Atoms are compared alphabetically.
#   4. Strings are compared alphabetically.
#   5. Numbers are compared by value. Integers and floats are treated identically. If the prolog_flag (see current_prolog_flag/2) iso is defined, all floating point numbers precede all integers.
#   6. Compound terms are first checked on their arity, then on their functor-name (alphabetically) and finally recursively on their arguments, leftmost argument first. 

class Unify(Term):
    """ +Term1 == +Term2
    Unify Term1 with Term2. Succeeds if the unification succeeds.
    """

    def __call__(self, s):
        return s.unify(*self.args)

class UnifyWithOccursCheck(Term):
    """ UnifyWithOccursCheck(+Term1, +Term2)
    As =/2, but using sound-unification. That is, a variable only unifies to a term if this term does not contain the variable itself.
    """

    def __call__(self, s):
        return s.unify_with_occurs_check(*self.args)

class _Comp:
    def _cmp(self, s, a, b):
        if isinstance(a, Term): return a.cmp(b, s)
        elif isinstance(b, Term): return -b.cmp(a, s)
        return cmp(a, b)

class Eq(Term2, _Comp):
    """ +Term1 == +Term2
    Succeeds if Term1 is equivalent to Term2. A variable is only identical to a sharing variable.
    """

    def __call__(self, s):
        if self._cmp(s, *self.args) == 0:
            yield s

class Ne(Term2, _Comp):
    """ +Term1 \== +Term2
    Equivalent to \+Term1 == Term2.
    """

    def __call__(self, s):
        if self._cmp(s, *self.args) != 0:
            yield s

class Lt(Term2, _Comp):
    """ +Term1 @< +Term2
    Succeeds if Term1 is before Term2 in the standard order of terms.
    """

    def __call__(self, s):
        if self._cmp(s, *self.args) < 0:
            yield s

class Le(Term2, _Comp):
    """ +Term1 @=< +Term2
    Succeeds if both terms are equal (==/2) or Term1 is before Term2 in the standard order of terms.
    """

    def __call__(self, s):
        if self._cmp(s, *self.args) <= 0:
            yield s

class Gt(Term2, _Comp):
    """ +Term1 @> +Term2
    Succeeds if Term1 is after Term2 in the standard order of terms.
    """

    def __call__(self, s):
        if self._cmp(s, *self.args) > 0:
            yield s

class Ge(Term2, _Comp):
    """ +Term1 @>= +Term2
    Succeeds if both terms are equal (==/2) or Term1 is after Term2 in the standard order of terms.
    """

    def __call__(self, s):
        if self._cmp(s, *self.args) >= 0:
            yield s

class Compare(Term3, _Comp):
    """ Compare(?Order, +Term1, +Term2)
    Determine or test the Order between two terms in the standard order of terms. Order is one of <, > or =, with the obvious meaning.
    """

    def __call__(self, s):
        order, term1, term2 = self.args
        o = self._cmp(s, term1, term2)
        if o < 0: return Unify(order, Lt)(s)
        if o > 0: return Unify(order, Gt)(s)
        return Unify(order, Eq)(s)

class Unifiable(Term):
    """ Unifiable(@X, @Y, -Unifier)
    If X and Y can unify, unify Unifier with a list of Var = Value, representing the bindings required to make X and Y equivalent. (26) This predicate can handle cyclic terms. Attributed variables are handles as normal variables. Associated hooks are not executed.
    """

    def __call__(self, s):
        for su in Unify(*self.args[:-1])(s):
            unifier = nil
            for var, val in su.vars.iteritems():
                unifier = cons(var==val, unifier)
            for sunifier in Unify(self.args[-1], unifier)(s):
                yield sunifier

# Control Predicates

class fail(Term0):
    """ fail
    Always fail. The predicate fail/0 is translated into a single virtual machine instruction.
    """

    def __call__(self, s):
        return iter(())

fail = fail()

class true(Term0):
    """ true
    Always succeed. The predicate true/0 is translated into a single virtual machine instruction.
    """

    def __call__(self, s):
        yield s

true = true()

class repeat(Term0):
    """ repeat
    Always succeed, provide an infinite number of choice points.
    """

    def __call__(self, s):
        while True:
            yield s

repeat = repeat()

def _group(G, Class):
    if isinstance(G, Class):
        return G.args
    else:
        return [G]

class And(Term2):
    """ +Goal1 , +Goal2
    Conjunction. Succeeds if both `Goal1' and `Goal2' can be proved.
    """

    def __call__(self, s):
        for s0 in self.args[0](s):
            for s1 in self.args[1](s0):
                yield s1

class Or(Term2):
    """ +Goal1 ; +Goal2
    Disjonction. Succeeds if one of `Goal1' and `Goal2' can be proved.
    """

    def __call__(self, s):
        try:
            for g in self.args:
                for gs in g(s):
                    yield gs
        except CutException:
            pass

class IfThenElse(Term3):
    """ +Condition -> +Action; +Else
    """

    def __call__(self, s):
        If, Then, Else = self.args
        cond = If(s)
        try:
            s_if = cond.next()
        except StopIteration:
            return Else(s)
        else:
            return Then(s_if)

"""

+Condition -> +Action
    If-then and If-Then-Else. The ->/2 construct commits to the choices made at its left-hand side, destroying choice-points created inside the clause (by ;/2), or by goals called by this clause. Unlike !/0, the choice-point of the predicate as a whole (due to multiple clauses) is not destroyed. The combination ;/2 and ->/2 acts as if defines by:

    If -> Then; _Else :- If, !, Then.
    If -> _Then; Else :- !, Else.
    If -> Then :- If, !, Then.

    Please note that (If -> Then) acts as (If -> Then ; fail), making the construct fail if the condition fails. This unusual semantics is part of the ISO and all de-facto Prolog standards.

+Condition *-> +Action ; +Else
    This construct implements the so-called `soft-cut'. The control is defined as follows: If Condition succeeds at least once, the semantics is the same as (Condition, Action). If Condition does not succeed, the semantics is that of (\+ Condition, Else). In other words, If Condition succeeds at least once, simply behave as the conjunction of Condition and Action, otherwise execute Else.

    The construct A *-> B, i.e. without an Else branch, is translated as the normal conjunction A, B. (28)

\+ +Goal
    Succeeds if `Goal' cannot be proven (mnemonic: + refers to provable and the backslash (\) is normally used to indicate negation in Prolog).

"""

if __name__ == '__main__':

    import sys

    for arg in sys.argv[1:]:
        if arg == '--version':
            print __version__
        else:
            print "Bad argument:", arg
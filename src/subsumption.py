'''
Created on Jul 8, 2014

@author: nkatz
'''

import re,functs,sys,excps,itertools,utils,structs,core,asp
from compiler.ast import flatten


gl = core.global_vals

def find_minimal_subsuming_subset(refined,supportset,**kwargs):
    notfound,result = True,[]
    if 'found_initial' in kwargs and kwargs['found_initial']:
        # then refined consists of a single clause, the initial
        # specialization. Check that in any case
        if len(refined) > 1:
            print('ERROR at find_minimal_subsuming_subset: len(refined) > 1') 
            sys.exit()
        elif len(refined) < 1: 
            print('ERROR at find_minimal_subsuming_subset: len(refined) == 0') 
            sys.exit()
        else:
            # do the work here.
            for x in supportset:
                if notfound:
                    initial_clause = [w for w in refined[0].as_str_list]
                    for i in range(1,len(x.body)+1):
                        y = itertools.combinations(x.body, i)
                        for y_ in y:
                            initial_clause.extend([y1.as_string for y1 in y_])   
                            initial_clause = structs.Clause(initial_clause,gl)
                            z = subsumes_program([initial_clause],supportset)
                            if z == True:    
                                notfound = False
                                result = initial_clause
                                break
                else: break                      
    else: 
        for i in range(1,len(refined)+1):
            if notfound:
                x = itertools.combinations(refined, i)
                for y in x:
                    z = subsumes_program(list(y),supportset) 
                    if z == True:
                        notfound = False
                        result = list(y)
                        break
            else: break        
    if notfound:
        pass
        #print(utils.see(refined))
        #print(utils.see(supportset))
        #msg = '[@EXMPLE %s:] Failed to find a support-subsuming refined program'%(str(gl.current_example))
        #raise excps.SupportSetException(msg,gl.logger)
    print('Found minimal subsuming subset')
    
    return result             

def subsumes_program(P1,P2):
    """ Returns True if each x in P2 is subsumed by at least
        one y in P1, or else (False,notsub) where notsub is the list
        of x in P2 that are not subsumed by any y in P1 """
    sub,notsub = [],[]
    for x1 in P1:
        for x2 in P2:
            if theta_subsumes(x1.as_str_list,x2.as_str_list):
                if not x2 in sub:
                    sub.append(x2)
    notsub = [x for x in P2 if x not in sub]            
    return True if set(sub) == set(P2) else (False,notsub)             

def theta_subsumes(clause1,clause2,**kwargs):
    (skolems,skolemized) = skolemize(clause2) 
    _vars = get_vars(clause1)
    modes_subs = False
    if 'modes_subsumption' in kwargs and kwargs['modes_subsumption']:
        modes_subs = True
    if modes_subs:
        if not asp.theta_subsumes(clause1,clause2): # speed up things a little...
            return (False,None)    
    while len(skolems) < len(_vars): # generate extra skolem constants if needed
        skolems += skolems
    for x in itertools.permutations(skolems):
        g = generate(clause1,_vars,x)
        if test(g,skolemized):
            if modes_subs:
                return (True,dict(zip(_vars,list(x))))
            else:
                return True
    if modes_subs:
        return (False,None)
    else:
        return False             

def test(subsumes,subsumed):
    return is_subset(subsumes,subsumed)

def generate(clause,_vars,skolems):
    return substitute(clause,_vars,skolems)

def skolemize(clause):
    if isinstance(clause,structs.Clause):
        _clause = clause.as_string
    else:
        _clause = clause    
    _vars = get_vars(_clause)
    if len(_vars) == 0: # then its a ground clause. Use its actual constants as skolem constants
        skolems = list(get_consts(_clause))
        return (skolems,_clause)
    else:    
        skolems = ['Skolem%s'%(str(i)) for i in range(0,len(_vars))]
    return ([s for s  in skolems],substitute(_clause,_vars,skolems)) 

def get_vars(clause):
    var_pattern = '\W[A-Z][A-Za-z0-9_]+|\W[A-Z]'
    if isinstance(clause,list):
        _vars = set(flatten([find(x,var_pattern) for x in clause]))
    if isinstance(clause,basestring):
        _vars = set(find(clause,var_pattern))    
    return tuple(_vars)
     
def get_consts(clause):    
    words_pattern = '[A-Za-z0-9_]+' 
    functs_pattern = '(\w+)\s*\('
    if isinstance(clause,list):
        words = flatten([find(x,words_pattern) for x in clause])
        functors = flatten([find(x,functs_pattern) for x in clause]) 
    if isinstance(clause,basestring):
        words = find(clause,words_pattern) 
        functors = find(clause,functs_pattern) 
    consts = [x for x in words if not x in functors]    
    return tuple(consts)
     
def substitute(clause,_vars,skolem_constants): 
    _map = dict(zip(_vars,skolem_constants))
    if isinstance(clause,basestring):
        term = functs.parse(clause)
        return _substitute(term,_map,[])
    elif isinstance(clause,list):
        return [_substitute(functs.parse(x),_map,[]) for x in clause]
    else:
        raise excps.ParsingException('Ill-formed term: %s')%(clause)    
     
def _substitute(term,vars_skolem_map,composed):
    is_var = lambda x,_map: any(x == z for z in _map)
    if isinstance(term,list):
            head_functor = term[0]
            if len(term) == 2: 
                _term = term
                for t in _term:
                    if is_var(t,vars_skolem_map):
                        _term = replace_all(t,vars_skolem_map[t],term)
                return '%s(%s)'%(head_functor,_term[1])
    elif isinstance(term,basestring): 
        return term if not is_var(term,vars_skolem_map) else vars_skolem_map[term]
    else: raise excps.ParsingException('Ill-formed term: %s')%(term)        
    for t in term[1:]:
        if isinstance(t,list) and all(isinstance(x,basestring) for x in t):
            functor = t[0]
            _t = t[1:]
            for x in _t:
                if is_var(x,vars_skolem_map):
                    _t = replace_all(x,vars_skolem_map[x],_t)
            _str = to_string(functor,_t)
            composed.append(_str)
        elif any(isinstance(x,list) for x in t):
            compose = []
            for x in t:
                _t = _substitute(x,vars_skolem_map,composed)
                compose.append(_t)
            _t = to_string(compose[0],compose[1:])         
            composed.append(_t)          
        elif isinstance(t,basestring):
            _t = vars_skolem_map[t] if is_var(t,vars_skolem_map) else t
            composed.append(_t)                             
        else:
            raise excps.ParsingException('Ill-formed term: %s')%(term)
    return to_string(head_functor,composed)
    
def replace_all(this,that,_list): 
    while this in _list:
        _list = replace_in_list(this,that,_list)
    return _list     

def replace_in_list(this,that,_list):
    _list[_list.index(this)] = that
    return _list
   
def to_string(functor,subterms):
    has_subterms = True if subterms != [] else False
    inner = ','.join([x for x in subterms]) if has_subterms else ''    
    return '%s(%s)'%(functor,inner) if subterms != [] else '%s'(functor)          
     
def find(literal,pattern):
    m = re.findall(pattern,literal)
    f = lambda x: x.replace(',','')
    g = lambda x: x.replace('(','')
    w = lambda x: x.replace(')','')
    return [f(g(w(x))) for x in m]    

def is_subset(x,y):
    return all(z in y for z in x)



b = ['initiatedAt(fluent(fighting,X3,X2),test(1,yes(no),Z),X1)','happensAt(event(active,X2),X1)']
#v = get_vars(b)
#print(v)
#print(substitute(b,v,('K','L','M','W')))
#print skolemize(b)

"""
# Tests:
# 1. An example of a clause that subsumes a shorter and more specific clause (see logical & relational learning):
a = ['q(X)','p(X,Y)','p(Y,X)']
x = ['q(A)','p(A,A)']
print theta_subsumes(a,x)

2. Mode declarations subsuming (i.e pattern-matching) ground atoms
a = ['holdsAt(close(X1,X2,X3),X4)']
b = ['holdsAt(close(id1,id2,40),10)']
print theta_subsumes(a,x)
"""
if __name__ == "__main__": 
    a = ['holdsAt(close(X1,X2,X3),X4)']
    b = ['holdsAt(close(id1,id2,40),10)']
    print(theta_subsumes(a,b))

#t = utils.variabilize_clause(['initiatedAt(fluent(fighting,X3,X2),X1)','happensAt(event(active,X2),X1)'])
#t = utils.variabilize_clause(['initiatedAt(fluent(fighting,id1,id2),10)','happensAt(event(active,id2),10)'])
#print(t.as_string)


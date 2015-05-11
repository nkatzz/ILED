'''
Created on Jul 2, 2014

@author: nkatz
'''
import re,excps,structs,sys
from compiler.ast import flatten
#from pyDatalog import pyDatalog

   

class Stack:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        return self.items.pop()

    def peek(self):
        return self.items[len(self.items)-1]

    def size(self):
        return len(self.items)


bts = lambda x: x.decode("utf-8") # bytes to string

compress = lambda x: [y for y in x if y.strip() != '']

de_sign = lambda x: x.replace('+','').replace('-','').replace('#','').strip()

joinwithAt = lambda _list: reduce(lambda x,y: str(x)+'@'+str(y),_list) if _list != [] else ''

replany = lambda x,y,z: x.replace(z,'').strip() if z in y else x  

aspunsat = lambda x: True if x != [] and x[0] == 'UNSATISFIABLE' else False

isempty = lambda x: True if x == [] else False

words = '[A-Za-z0-9_]+'

plmrks = lambda x,y: re.findall('\\'+str(y)+words,x) # call it like plmrks(modedecl,'+/-/#')

plmrkslen = lambda x,y: len(re.findall('\\'+str(y)+words,x)) # call it like plmrkslen(modedecl,''+/-/#')

plm_search_pattern = lambda x,y: [x.replace(plmrks(x,y)[i],'X',i+1) for i in range(0,plmrkslen(x,y))]

replallrest = lambda x,y: re.sub('\\'+str(y)+words,'_',x)

determ = lambda x: x.split('term(')[1].split(')')[0].split(',')

split_use_2_3 = lambda x: ([y for y in x if is_use_2(y)],[y for y in x if is_use_3(y)])

is_use_2 = lambda x: True if 'use' in x and len(re.findall('[0-9]+',x)) == 2 else False

is_use_3 = lambda x: True if 'use' in x and len(re.findall('[0-9]+',x)) == 3 else False

is_in = lambda x,y: True if x in y else False

filter_retained = lambda x,y: ([y[k] for k in y if is_use_3(k) and not is_in(k,x)], [y[k] for k in y if is_use_3(k) and is_in(k,x)]) 

is_specld = lambda x: True if 'specialize' in x else False

clause = lambda x: re.findall('\d+',x)[0]

insolution = lambda i,x: True if i in [de_use_3(y,'i') for y in x] else False

filter_retained_ = lambda x,y: ([y[k] for k in y if is_specld(k) and not insolution(clause(k),x)],
                                [(clause(k),y[k]) for k in y if is_specld(k) and insolution(clause(k),x)])

form_revised = lambda clindex,initclause,usedict,use_3: \
               [initclause.head].extend(initclause.body).extend([usedict[x] for x in use_3 if de_use_3(x,'i') == clindex])

def form_revised_(clindex,initclause,usedict,use_3):
    a = [initclause.head]
    a.extend(initclause.body)
    a.extend([usedict[x] for x in use_3 if de_use_3(x,'i') == clindex])
    return a

def de_use_2(use_atom,coord):
    m = re.findall('[0-9]+',use_atom)
    if coord == 'i':
        return m[0]
    if coord == 'j':
        return m[1]

def de_use_3(use_atom,coord):
    m = re.findall('[0-9]+',use_atom)
    if coord == 'i':
        return m[0]
    if coord == 'j':
        return m[1]
    if coord == 'k':
        return m[2]

def head_body_use_atoms_filter(use_atoms):
    head_use_atoms = filter(lambda x: de_use_2(x, 'j') == '0', use_atoms) 
    _map = [('use(%s,0)'%(i),[x for x in use_atoms if \
            de_use_2(x, 'i') == i and not de_use_2(x, 'j') in '0']) \
              for i in map(lambda x: de_use_2(x, 'i'),head_use_atoms)]
    
    # check if every use(i,j) atom has a corresponding use(i,0) atom
    x = flatten([d[1] for d in _map])
    for y in head_use_atoms: x.append(y)
    _x = set(x)
    return (_x == set(use_atoms),_map)
    
def parse(atom):
    stack = Stack()
    buffer,subterms,out = '',[],None
    for x in atom:
        if x in '(': # A new compound term is starting
            stack.push([buffer])
            buffer = ''
            
        elif x in ',': # A new simple term (var or constant is starting)
            if buffer.strip() != '':
                stack.peek().append(buffer)
            buffer = ''
        elif x in ')': # A compound term is completed
            out = stack.pop()
            out.append(buffer)
            if stack.items != []:
                stack.peek().append(out)
            buffer = ''
           
        else: # A term is being parsed
            buffer += str(x)
    if out == None:
        raise excps.ParsingException('Parsing error: Ill-formed atom %s'%(atom))        
    return out        


 
class Term:
    
    """ This parses an atom into a list-of-lists representation of a term """
    
    def __init__(self,atom):
        self.functor = None
        self.subterms = []
        self.as_string = ''
        self.is_compound = None
        if isinstance(atom,basestring):
            c = parse(atom)
        elif isinstance(atom,structs.Literal):
            atom = atom.as_string
            c = parse(atom)
        else:
            msg = 'Tried to parse a literal but got %s instead of string or structs.Literal'%(type(atom))
            raise excps.ParsingException(msg)    
        self.parsed = c 
        self.is_compound = len(c) == 1
        self.functor = c[0]
        self.subterms = c[1:]
        self.as_string = atom
        self.arity = len(self.subterms)

    def get_subterm(self,term_list):
        term = []
        for x in term_list:
            if self.is_simple_term(x):
                self.subterms.append(x) 
            elif self.is_flat_term(x):
                _t = Term(x)
                term.append(_t.as_string)
            else:
                self.get_subterm(x)   
        a = term.pop(0)             
        self.subterms.append(self.as_string(a, term))        
    
    def is_flat_term(self,term_list) :
        test = map(lambda x: isinstance(x, basestring),term_list)
        test = reduce(lambda x,y: x and y,test)
        return test and isinstance(term_list, list)
    
    def is_simple_term(self,term):
        return True if isinstance(term, basestring) else False
    
    def compose(self,term,composed):
        """ Creates a string from a list-of-lists representation of a term """
        if isinstance(term,list):
            head_functor = term[0]
            if len(term) == 2:
                return '%s(%s)'%(head_functor,term[1])
        elif isinstance(term,basestring):
            return term
        else:
            raise excps.ParsingException('Ill-formed term: %s')%(term)        
        for t in term[1:]:
            if isinstance(t,list) and all(isinstance(x,basestring) for x in t):
                functor = t[0]
                _str = self.to_string(functor,t[1:])
                composed.append(_str)
            elif any(isinstance(x,list) for x in t):
                compose = []
                for x in t:
                    _t = self.compose(x,[])
                    compose.append(_t)
                _t = self.to_string(compose[0],compose[1:])         
                composed.append(_t)          
            elif isinstance(t,basestring):
                composed.append(t)                             
            else:
                raise excps.ParsingException('Ill-formed term: %s')%(term)
        return self.to_string(head_functor,composed)        
    
    def to_string(self,functor,subterms):
        has_subterms = True if subterms != [] else False
        inner = ','.join([x for x in subterms]) if has_subterms else ''    
        return '%s(%s)'%(functor,inner) if subterms != [] else '%s'(functor) 
    
    def get_term_at(self,i):
        if i < len(self.subterms):
            return self.subterms[i]
        else:
            return None    


def plm_pattern(mode,search_symb):
    symbs = ['+','-','#']
    rest_symbs = [s for s in symbs if s not in search_symb]
    m = mode
    for s in rest_symbs:
        m = re.sub('\\'+s+words,'_',m) 
    plm = plmrks(mode,search_symb)
    d,out = {},[]
    for mo in plm:
        if mo in d:
            n = d[mo]
            m1 = replace_nth(m,mo,'X',n+1) 
            out.append((replallrest(m1,search_symb),de_sign(mo)))
            d[mo] += 1
        else:
            m1 = replace_nth(m,mo,'X',1) 
            out.append((replallrest(m1,search_symb),de_sign(mo)))
            d[mo] = 1
    
    return out
    
def find_nth(source, target, n):
    num = 0
    start = -1
    while num < n:
        start = source.find(target, start+1)
        if start == -1: return -1
        num += 1
    return start

def replace_nth(source, old, new, n):
    p = find_nth(source, old, n)
    if n == -1: return source
    return source[:p] + new + source[p+len(old):]   

def replace_body_decl(in_term_dict,bodyd):
    """ Replace the input plmrks in a body declaration with input variables from inlist and
        replace each term that corresponds to a constant or outvar with a fresh var """
    res = bodyd
    inplmrks = plmrks(res,'+')
    outplmrks = plmrks(res,'-')
    grplmrks = plmrks(res,'#')
    inlist = [key for key in in_term_dict] 
    from random import randint
    for inp in inplmrks:
        ind = randint(0,len(inlist)-1)
        replace_term = inlist[ind]
        count = 0
        while in_term_dict[replace_term] != de_sign(inp): # make sure you substitute things of the same type
            #print(in_term_dict,bodyd,in_term_dict[replace_term],replace_term,de_sign(inp))
            ind = randint(0,len(inlist)-1)
            replace_term = inlist[ind]
            count += 1
            if count == 1000:
                stop = 'here' 
        d = {}
        if inp in d:
            n = d[inp]
            res = replace_nth(res,inp,replace_term,n+1) 
            d[inp] += 1
        else:
            res = replace_nth(res,inp,replace_term,1) 
            d[inp] = 1
    varcount = 0
    for o in outplmrks:
        if o in d:
            n = d[o]
            res = replace_nth(res,o,'X'+str(varcount),n+1) 
            d[o] += 1
            varcount += 1
        else:
            res = replace_nth(res,o,'X'+str(varcount),1) 
            varcount += 1
            d[o] = 1
    for g in grplmrks:
        if g in d:
            n = d[g]
            res = replace_nth(res,g,'X'+str(varcount),n+1) 
            d[g] += 1
            varcount += 1
        else:
            res = replace_nth(res,g,'X'+str(varcount),1) 
            varcount += 1
            d[g] = 1
    return res           
              
              
                       




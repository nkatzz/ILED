'''
Created on Jul 6, 2014

@author: nkatz
'''

import core,structs,utils,os

gl = core.global_vals

def py_load_from_file():
    """ Compiles a theory from a python lists representation. The representation must be like:
    
        [[head,body_1,...,body_n][support_head_1,support_body_1,...support_body_n],...[support_head_m,support_body_m1,...support_body_mn]]
     """
    #dir = core.global_vals.py_prior_theory_debug
    #prior = []
    
    import sys
    sys.path.append('/home/nkatz/Desktop/py-ILED/dev-debug')
    sys.path.append(dir)
    import debug_prior_theory #@UnresolvedImport
    inp1 = debug_prior_theory.clause1
    inp2 = debug_prior_theory.clause2
    #inp3 = debug_prior_theory.clause3
    c1 = generate(inp1)
    c2 = generate(inp2)
    #c3 = generate(inp3)  
    return [c1,c2]        

def generate(c):
    t = structs.Clause(c[0],core.global_vals)
    new = utils.variabilize_clause(t)
    #print(newclause.as_string) 
    c.pop(0)
    for x in c:
        s = structs.Clause(x,core.global_vals)
        ss = utils.variabilize_clause(s)
        new.support.append(ss)
    return new    
    

def load_theory_from_file():
    """ Compiles a theory from a clausal-like string representation. Clauses must be given in the form
        head :-
           body1,
           ...
           bodyn.
     """
    prior_theory_path = core.global_vals.prior_theory_debug
    clauses = []
    with open(prior_theory_path,'r') as f:
        #for line in f.read().splitlines():
        #    print(line)
        lines = [line.strip() for line in f.read().splitlines() if not line.startswith('%') and not line.strip() in '']
        clause = []
        for line in lines:
            if ':-' in line:
                clause.append(line.split(':-')[0])
            else:
                #clause.append(line.split(line[-1:])[0])    
                #clause.append(line.split(line[len(line)-1])[0])
                trimmed = trimm_trailing(line)
                clause.append(trimmed)
                if '.' in line:
                    clauses.append(clause)
                    clause = []  
    t = [structs.Clause(c,core.global_vals) for c in clauses] 
    _t = utils.variabilize_theory(t)
    for c in _t:
        c.support = [c] # just add some support to debug  
    return _t
    #return clauses                    

def trimm_trailing(str):
    t = str[::-1][1:] # reverse the string and trimm the first character ('.' or ',')
    return t[::-1]    # reverse it again and return it      
       
def check_on_previous():
    """ Test a hypothesis on all previous examples """      
    t = gl.current_hypothesis 
    new = t['new']
    specialized = t['specialized']
    retained = ['retained']
    x = utils.merge_all_lists([new,specialized,retained])
    cwd = os.getcwd()
    testpath = os.path.join(os.path.dirname(cwd),'runtime','test_file.lp')
    testfile = open(testpath, 'w')
    for y in x:
        testfile.write(y.as_string_with_var_types)
        testfile.write('\n\n')
    testfile.write('#hide.')
    testfile.close()
    import asp
    allok = False
    for i in gl.seen_examples:
        utils.get_example(i)
        if not asp.test_hypothesis(debug=True):
            print('unsatisfiable at example %s')%(str(i))
            allok = True
    if allok:
        print('Hypothesis consistent with all past examples')        
    os.remove(testfile)                
            
"""
t = load_theory_from_file()            
for c in t:
    print(c.as_string)
"""

#py_load_from_file()    
     

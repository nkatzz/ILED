'''
Created on Jul 2, 2014

@author: nkatz
'''

import core,os,excps,subprocess,sys
#import utils

command = None
#gl = core.core().globals
gl = core.global_vals
bk = gl.bk
ex = gl.examples
clingo = gl.clingo
abdinp = gl.abdinp
dedin = gl.dedinp
indin = gl.indinp
gr = gl.ground 
test_theory = gl.prior_theory_path
exmpl_constr = gl.example_coverage_constr
exmpl_constr_rej = gl.example_reject_constr
subsumes_file = gl.subsumes
#caviar_constr = gl.caviar_constr

def cmd(options):
    result = []
    options = [clingo,bk,ex,test_theory,exmpl_constr,'0', '--asp09']
    try:
        p = subprocess.check_output(options,stderr=subprocess.STDOUT)
        result = p
    except Exception, e:
        result = str(e.output)
        result = result.splitlines()
        result = [x.split('.')[0] for x in result if not x.strip()=='' and not 'warning' in x]     
        #if result != []:
        #    result = result[0].split('.')
        #    result = [x.strip() for x in result if not x.strip()=='']
        #    print(result)
    return result

#cmd() 

def abd(**kwargs):
    global command
    import utils
    if not 'simple_update' in kwargs:
        hs,scs,cls = kwargs['heuristic_search'],kwargs['set_cover_search'],kwargs['clause_level_search']
        special_search = hs or scs or cls
    else:
        special_search = False    
    if not special_search:
        options = [clingo,bk,ex,abdinp,exmpl_constr,'1','--asp09'] 
    else:
        options = [clingo,bk,ex,abdinp,exmpl_constr,'1','--asp09']    
        covfile = gl.example_coverage_constr  # use the hard example coverage constraints
        covconstr = gl.example_constraints_cover
        covcontent = '\n'.join(covconstr)
        utils.write_to_file(covfile,covcontent)
    command = ' '.join(options)
    out = os.popen(command).read().split('.')
    

    #out = [x.strip() for x in out if not x.strip() == '']
    
    out = filter(lambda x: 'OPTIMUM FOUND' not in x,out)
    ##out = out[len(out)-1].split('.') # get the last one, which is the optimum
    out = filter(lambda x: not x.strip() in '',[x.strip() for x in out ])
    
    
    
    if special_search: # re-write the soft constraints
        covfile = gl.example_coverage_constr  # use the hard example coverage constraints
        covconstr = gl.heuristic_example_constraints_cover
        covcontent = '\n'.join(covconstr)
        utils.write_to_file(covfile,covcontent)
    return out
   
def ded():    
    global command
    options = [clingo,bk,ex,dedin,'1 --asp09']
    command = ' '.join(options)
    out = os.popen(command).read().split('.')
    out = [x.strip() for x in out if not x.strip() == '']
    return out

def ind(**kwargs):    
    global command
    kernel_gen,all_opt,all_optimal,incremental_search,incremental_solve = False,False,False,False,False
    inc_solve_init_model,inc_solve_improve_model = False,False
    if 'kernel_generalization' in kwargs and kwargs['kernel_generalization']:
        kernel_gen = True
        if 'incremental_search' in kwargs and kwargs['incremental_search']:
            options = [clingo,bk,ex,indin,'0']
            incremental_search = True
        elif 'incremental_solve' in kwargs and kwargs['incremental_solve']: 
            incremental_solve = True
            if 'init_model' in kwargs and kwargs['init_model']:
                options = [clingo,bk,ex,indin,exmpl_constr,'1']
                inc_solve_init_model = True
            elif 'improve_model' in kwargs and kwargs['improve_model']:
                opt = kwargs['opt']    
                options = [clingo,bk,ex,indin,exmpl_constr,'1 --opt-value=%s --opt-all'%(opt)]
                inc_solve_improve_model = True
            else: pass
        else:
            options = [clingo,bk,ex,indin,exmpl_constr,'0 --asp09']
    elif 'find_all_optimal' in kwargs and kwargs['find_all_optimal']:    
        all_opt = True
        if 'incremental_search' in kwargs and kwargs['incremental_search']:
            opt = kwargs['opt']
            options = [clingo,bk,ex,indin,'0 --opt-value=%s --opt-all --asp09'%(opt)]
            all_optimal = True
            incremental_search = True
        else:
            #options = [clingo,bk,ex,indin,exmpl_constr_rej,'0 --asp09']
            options = [clingo,bk,ex,indin,exmpl_constr,'0 --asp09']
    elif 'recheck_hist_memory' in kwargs and kwargs['recheck_hist_memory']:    
        all_opt = True
        #options = [clingo,bk,ex,indin,exmpl_constr_rej,'0 --asp09']
        options = [clingo,bk,ex,indin,exmpl_constr,'0 --asp09']  
    else:
        pass       
    command = ' '.join(options)
    out = os.popen(command).read().splitlines()
    if not incremental_search and not incremental_solve:
        out = filter(lambda x: 'OPTIMUM FOUND' not in x,out)
        out = out[len(out)-1].split('.') # get the last one, which is the optimum
        out = filter(lambda x: not x.strip() in '',[x.strip() for x in out ])
        if out != []:
            if out[0] == 'UNSATISFIABLE':
                if kernel_gen:
                    msg = 'UNSATISFIABLE program while generalizing Kernel Set at example %s'%(str(gl.current_example))
                elif all_opt:
                    #msg = 'UNSATISFIABLE program while computing all optimal refinements at example %s'%(str(gl.current_example))
                    #return [] # it may be the case that while searching a single support set you may get unsat results 
                    print('UNSAT while refining hypothesis')
                    sys.exit()
                else:
                    msg = 'UNSATISFIABLE program at induction phase at example %s'%(str(gl.current_example))       
                if not 'incr_kernel_search' in kwargs:
                    raise excps.InductionException(msg,gl.logger)
                else:
                    return 'UNSATISFIABLE'
            else:
                return out
        else:
            return out 
    # else, we need all optimal models. This occurs when searching the kernel set incrementally, 
    # in which case the examples are soft constraints. Thus test for satisfiability potentially
    # resulting in InductionException as above are not needed, because this may never happen here.      
    else: 
        if not incremental_solve:
            if not all_optimal:
                out = [x.lstrip().rstrip() for x in out]
                index = out.index('OPTIMUM FOUND')
                optline = out[index-1]
                lastmodel = out[index-2]
                lastmodel = lastmodel.split(' ')
                use_atoms = [x for x in lastmodel if 'use' in x]  
                pos_covered = [y for y in lastmodel if 'posCovered' in y][0]
                negs_covered = [z for z in lastmodel if 'negsCovered' in z][0]
                pos_covered = int(pos_covered.split('posCovered(')[1].split(')')[0])
                negs_covered = int(negs_covered.split('negsCovered(')[1].split(')')[0])
                opt = optline.split('Optimization:')[1].strip()
                return (use_atoms,pos_covered,negs_covered,int(opt))
            else:
                solutions,pos,negs = [],0,0
                out = filter(lambda x: 'OPTIMUM FOUND' not in x,out)
                for solution in out:
                    to_list = solution.split('. ')
                    use_atoms = [x for x in to_list if 'use' in x]  
                    pos_covered = [y for y in to_list if 'posCovered' in y][0]
                    negs_covered = [z for z in to_list if 'negsCovered' in z][0]
                    pos_covered = int(pos_covered.split('posCovered(')[1].split(')')[0])
                    negs_covered = int(negs_covered.split('negsCovered(')[1].split(')')[0])
                    pos = pos_covered
                    negs = negs_covered
                    solutions.append(use_atoms)
                return (solutions,pos,negs) 
        else:
            out = [x.lstrip().rstrip() for x in out]
            if any('UNSATISFIABLE' in z for z in out):
                if inc_solve_init_model: # Fail here
                    msg = 'UNSATISFIABLE program at induction phase at example %s'%(str(gl.current_example))
                    raise excps.InductionException(msg,gl.logger)
                else:
                    return ('UNSATISFIABLE',0)
            else:    
                optindex = 0
                for line in out:
                    if 'Optimization:' in line:
                        optindex = out.index(line) 
                        break        
                optimization = out[optindex].split('Optimization:')[1].strip()    
                model = out[optindex-1].split(' ')    
                return (model,int(optimization))

  
def find_all_optimal():
    out = ind(find_all_optimal = True)
    if out == []: # then at worst a single kernel clause failed to give result, pass it.
        return []
    opt = len(out)
    #options = [clingo,bk,ex,indin,exmpl_constr_rej,'0 --opt-value=%s --opt-all --asp09'%(opt)]
    options = [clingo,bk,ex,indin,exmpl_constr,'0 --opt-value=%s --opt-all --asp09'%(opt)]
    command = ' '.join(options)
    out = os.popen(command).read().splitlines()
    out = filter(lambda x: 'OPTIMUM FOUND' not in x,out)
    out = out[len(out)-1].split('.') # get the last one, which is the optimum
    out = filter(lambda x: not x.strip() in '',[x.strip() for x in out ])
    if out[0] == 'UNSATISFIABLE':
        msg = 'UNSATISFIABLE program while computing all optimal refinements at example %s'%(str(gl.current_example))
        raise excps.InductionException(msg,gl.logger)
    else:
        return out
        
def ground():
    global command
    options = [clingo,gr,'0 --asp09']
    command = ' '.join(options)
    out = os.popen(command).read().split('.')
    out = set([x.strip() for x in out if not x.strip() == ''])
    return out

def test_hypothesis(**kwargs):
    """
    Test a hypothesis on examples. How to call:
    -  If called with no kwargs it simply checks a hypothesis on gl.current_example (normal mode)
    -  If called with kwargs = {example:i}, where i is an integer then its gets example
       i from hte database, performs check and cleans up, i.e it restores gl.current_example (debugging mode)
    -  If called with kwargs = {example:'all'} it checks a hypothesis on all seen examples
       and cleans up afterwards. (debugging mode)    
     """
    import utils
    current_example = gl.current_example # remember to clean up later 
    if kwargs == {}: # default   
        return test_default()
    else:
        if 'example' in kwargs: # perform a test with a specific example (for debugging)
            i = kwargs['example']
            if utils.isint(i):
                utils.get_example(i)
                return test_default(last_seen = current_example)
            else: # then we want to check all seen examples for correctness (argument = 'all')
                return test_all(current_example)
        
def test_all(last_example):
    import utils
    all_,unsat = True,[]
    for i in gl.seen_examples:
        utils.get_example(i)
        test = test_hypothesis
        if not test:
            all_ = False
            unsat.append(i)
    utils.get_example(last_example) # clean up
    if all_:
        print('Hypothesis ok with all seen examples')
    else:
        print('Not ok with %s')%(','.join([str(x) for x in unsat]))     
    return (all_,unsat)     

def test_default(**kwargs):
    import utils
    result = None
    testfile = test_theory
    options = [clingo,bk,ex,testfile,exmpl_constr,'0 --asp09']
    command = ' '.join(options)
    out = os.popen(command).read().split('. ')
    if out[0].strip() == 'UNSATISFIABLE':
        result = False
    else:    
        out = set([x.strip() for x in out if not x.strip() == ''])
        out = filter(lambda x: 'OPTIMUM FOUND' not in x,out)
        if list(out) == [] :
            result = True
        elif all('posCovered' in x or 'negsCovered' in x for x in out):
            (_,_,score) = utils.get_score(out)
            if score == gl.current_example_object.positive_count:
                return True
            else:
                return False     
        else:
            raise excps.HypothesisTestingException('ASP reasoner returned %s'%(' '.join(out)),gl.logger) 
    if 'last_seen' in kwargs:
        if result:
            print(gl.current_example,'ok')
        else:
            print(gl.current_example,'Not ok!')
        i = kwargs['last_seen']
        utils.get_example(i)   
    return result
     
     
def show_negs(**kwargs):
    testfile = test_theory
    options = [clingo,bk,ex,testfile,exmpl_constr,'0 --asp09']
    command = ' '.join(options)
    out = os.popen(command).read().split('. ')
    print(out)     


""" This checks subsumption by calling prolog. It's too slow to be used 
    for parsing strings into term representation (which typically happens hundreds
    of thousands of times. For now it's retained for checking subsumption between clauses). """
"""    
def theta_subsumes_clause(clause1,clause2):
    to_str_list = lambda x: '[%s]'%(','.join(x))      
    options = ['yap','-q','-f',subsumes_file,'-g','\"run(%s,%s).\"'%(to_str_list(clause1),to_str_list(clause2))]  
    command = ' '.join(options)
    out = os.popen(command).read().strip()
    return True if out == 'yes' else False
"""

#def theta_subsumes_mode(modedecl,atom):

def theta_subsumes(modedecl,atom):
    import functs
    c1,c2 = modedecl[0],atom[0]  
    t1,t2 = functs.Term(c1),functs.Term(c2)
    test1 = t1.functor == t2.functor and t1.arity == t2.arity
    #test2 = map(lambda x,y: x.functor == y.functor if x.is_compound and y.is_compound else False,t1.subterms,t2.subterms)
    test3 = reduce(lambda x,y: x and y,
                   map(lambda x,y: x[0] == y[0] 
                       if isinstance(x,list) and isinstance(y,list) else True, t1.subterms,t2.subterms))
    #return test1 and test2 and test3
    return test1 and test3


    
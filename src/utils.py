'''
Created on Jul 2, 2014

@author: nkatz
'''

import core,functs,re,asp,sys
from compiler.ast import flatten
import structs,excps
import subsumption
import itertools,os
import incremental_kernel_search

gl = core.global_vals

#def revise(is_new_example,*debug):
def revise(**kwargs):
    hs,scs,cls = kwargs['heuristic_search'],kwargs['set_cover_search'],kwargs['clause_level_search']
    special_search =  scs or cls
    if not special_search:
        gl.use_dict = {}
        is_new_example = kwargs['is_new_example'] 
        debug_mode = kwargs['debug'] if 'debug' in kwargs else False # keep this optional
        retained,new,refined = kwargs['retcl'],kwargs['newcl'],kwargs['refcl'] 
        if debug_mode: 
            import debug_utils
            prior_theory = debug_utils.py_load_from_file() 
        else:
            prior_theory = [retained,new,refined]
            prior_theory_ = [x for y in prior_theory for x in y]
            if is_new_example:
                #retained.extend(refined) # that's a patch because due to a bug previously refined clauses are left out  
                generate_kernel(**kwargs) 
                var_kernel = gl.current_var_kernel
                if 'search_subsets' in kwargs:
                    search_kernel_by_subsets(prior_theory_)   
                elif 'incremental_solve' in kwargs and kwargs['incremental_solve']:
                    (solution,use_2,use_3) = incremental_solve(var_kernel,prior_theory_) 
                    
                else: 
                    
                    analyze_use_try(gl.current_var_kernel,prior_theory_)
                    out = asp.ind(kernel_generalization=True)
                    (use_2,use_3) = functs.split_use_2_3(out)
                    (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                    if ok :
                        new = form_new_clauses(use_head_body_map)
                    else:
                        msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
                        raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
                       
                    
                                   
                (retained,revisable) = functs.filter_retained_(use_3,gl.use_dict)
                update_support(retained)
            else: # re-seeing past example
                #prior_theory = [retained,refined]
                # Only analyze the new clauses generated last. 
                # Update This is messy...Analyze it all, there is no serious overhead
                #analyze_use_try([],new,preserve=[x for y in prior_theory for x in y])
                analyze_use_try([],prior_theory_)
                out = asp.ind(recheck_hist_memory=True)
                (_,use_3) = functs.split_use_2_3(out) # no use/2 here
                (retained,revisable) = functs.filter_retained_(use_3,gl.use_dict) 
            revisable_ = []
            for (clause_index,clause) in revisable:
                #import debug_utils
                #debug_utils.check_on_previous()
                revcl = functs.form_revised_(clause_index,clause,gl.use_dict,use_3)
                revcl = structs.Clause(revcl,gl)
                revisable_.append((clause,revcl))
            incorrects = [inx[0] for inx in revisable_]    
            specialized = []    
            for (incorrect,one_solution) in revisable_ : # need to find optimal refinement
                optimal_ref = one_solution 
                check_prior = [z for z in prior_theory_ if not z in incorrects]
                if search_more(initsol=one_solution,parent=incorrect,prior=check_prior):
                    other_init_solutions = [x[1] for x in revisable_ if x[1] != one_solution]
                    check_prior.extend(other_init_solutions)
                    optimal_ref = get_optimal_refinement(initsol=one_solution,
                                                     parent=incorrect,
                                                     prior=check_prior)
                if isinstance(optimal_ref,list): # then it went through get_optimal_refinement because that returns a list  
                    specialized.extend(optimal_ref)
                else:
                    if isinstance(optimal_ref,structs.Clause): # then it's the initial solution, no support update yet
                        update_support((incorrect,optimal_ref))# this must be passed as a (parent,child) tuple
                        specialized.append(optimal_ref)
    
        #d = dict(zip(incorrects,specialized))
        if is_new_example:
            (n,r,s) = (new,retained,specialized)
        else:
            (n,r,s) = ([],retained,specialized)                    
    
        updateprior(n,r,s)
        return (n,r,s) 
    else:
        if kwargs['set_cover_search']:
            return set_cover_search(**kwargs)
        elif kwargs['heuristic_search']:
            return heuristic_search(**kwargs)
        else:
            #return incremental_kernel_search.incremental_search(**kwargs)
            return incremental_kernel_search(**kwargs)

def incremental_solve(input_program,prior_theory_,**kwargs):
    analyze_use_try(input_program,prior_theory_) 
    can_do_better = True
    # get an initial model:
    if not 'opt' in kwargs:
        (initial_model,optimization) = asp.ind(kernel_generalization=True,
                                               incremental_solve=True,
                                               init_model=True)
    else:
        (initial_model,optimization) = asp.ind(kernel_generalization=True,
                                               incremental_solve=True,
                                               improve_model=True,opt=kwargs['opt'])
    if initial_model != 'UNSATISFIABLE':        
        (solution,use_2,use_3) = form_program(initial_model,incremental_solve=True)
        while can_do_better:
            print('optimization: %s'%(str(optimization)))
            optimization -= 1
            if optimization == 28:
                stop = 'stop' 
            analyze_use_try(solution,prior_theory_)
            (better_model,_) = asp.ind(kernel_generalization=True,
                               incremental_solve=True,
                               improve_model=True,opt=optimization)
            if better_model == 'UNSATISFIABLE':
                # There are two cases here: Either we reached the true optimal
                # theory size, or we took a path (with the initial "seed" model) that
                # cannot be further improved, while in fact better hypotheses
                # are possible. So first try to back-jump to the initial Kernel Set, 
                # to see if we can find a better "seed" model of the current size. 
                # If that fails, then we arrived at the optimum.
                return incremental_solve(input_program,
                                         prior_theory_,
                                         opt=optimization,
                                         last_model=solution,
                                         use2model=use_2,
                                         use3model=use_3) 
                can_do_better = False
            else:
                (solution,use_2,use_3) = form_program(better_model,incremental_solve=True) 
    else:
        solution = kwargs['last_model']
        use_2 = kwargs['use2model']
        use_3 = kwargs['use3model']
    """
    ===================================================
    Remember to update supports for the final solution
    ===================================================
    """        
    print('Found optimal')
    return (solution,use_2,use_3)           

def form_program(model,**kwargs):
    (use_2,use_3) = functs.split_use_2_3(model)
    (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
    if ok :
        program = form_new_clauses(use_head_body_map,**kwargs)
    else:
        msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
        raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
    return (program,use_2,use_3)

def search_kernel_by_subsets(prior_theory_):
    var_kernel = gl.current_var_kernel
    found_solution = False
    while not found_solution: 
        for i in range(6,len(var_kernel)+1):
            i_subsets = itertools.combinations(var_kernel, i)
            subset_counter = 0
            for subset_ in i_subsets: 
                subset = list(subset_)
                print('Searching #%s kernel %s-subset:'%(str(subset_counter),str(i)))
                analyze_use_try(subset,prior_theory_)  
                #analyze_use_try(gl.current_var_kernel,prior_theory_)
                out = asp.ind(kernel_generalization=True,incr_kernel_search=True)
                print(out)
                if out != 'UNSATISFIABLE': 
                    (use_2,use_3) = functs.split_use_2_3(out)
                    (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                    if ok :
                        new = form_new_clauses(use_head_body_map)
                    else:
                        msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
                        raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
                        found_solution = True
                        subset_counter += 1    
                if found_solution:
                        break
            if not found_solution:
                print('Failed to find a solution')
                sys.exit() 

def incremental_kernel_search(**kwargs):
    gl.use_dict = {}
    is_new_example = kwargs['is_new_example'] 
    retained,new,refined = kwargs['retcl'],kwargs['newcl'],kwargs['refcl']
    prior_theory = [x for y in [retained,new,refined] for x in y]
    positive_count = gl.current_example_object.positive_count
    if is_new_example:
        generate_kernel(**kwargs)
        # revise the clauses in the prior theory one by one first
        for c in prior_theory: # TODO
            pass
        # generate new clauses from the Kernel Set, using iterative deepening
        # on the subsets of the Kernel Set, until a solution is found.
        #------------------------------------------------------------------------------
        # TODO: This strategy can be modified to return approximate solution. This 
        # may be useful in cases where large effort is required to obtain a correct
        # hypothesis, or in cases where a correct hypothesis does not exist (noise).
        # A straightforward strategy towards this is to keep the best hypothesis found
        # within a max_iterations bound.  
        #-------------------------------------------------------------------------------
        var_kernel = gl.current_var_kernel 
        found_solution = False
        already_found = []
        for i in range(1,len(var_kernel)+1):
            i_subsets = itertools.combinations(var_kernel, i)
            for subset_ in i_subsets: 
                subset = list(subset_)
                analyze_use_try(subset,[])  
                out = asp.ind(kernel_generalization=True)
                #==============================================================================
                # Test code. Try to add what you get from each subset to the bk in an effort
                # to further reduce solving time. 
                (use_2,use_3) = functs.split_use_2_3(out)
                (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                if ok :
                    new = form_new_clauses(use_head_body_map)
                    if new != []:
                        already_found.extend(new)
                        n = '\n\n'.join(map(lambda x: x.as_string_with_var_types ,already_found))
                        write_to_file(gl.helper, n)
                else:
                    msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
                    raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
                #===============================================================================
                pos,negs,score = get_score(out)
                print(str(i)+'-subsets',pos,negs,score)
                if score == positive_count:
                    #------------------
                    print('Found it')
                    sys.exit()
                    #------------------
                    found_solution = True
                    (use_2,use_3) = functs.split_use_2_3(out)
                    (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                    if ok :
                        new = form_new_clauses(use_head_body_map)
                    else:
                        msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
                        raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
                    (retained,revisable) = functs.filter_retained_(use_3,gl.use_dict)
                    update_support(retained)
                    break # stop searchin i-level subsets
            if found_solution:
                break # stop searching subsets   
        if not found_solution:
            print('unsat at kernel generalization')
            sys.exit()    
    else: # TODO
        pass    

def get_score(atoms):
    pos,negs,use_atoms_count = 0,0,0
    for x in atoms:
        if 'posCovered' in x:
            pos = int(x.split('posCovered(')[1].split(')')[0])
        elif 'negsCovered' in x:
            negs = int(x.split('negsCovered(')[1].split(')')[0])
        elif 'use' in x:
            use_atoms_count += 1
    score = pos - negs    
    return (pos,negs,score)   

def set_cover_search(**kwargs):
    print('Non implemented yet')
    sys.exit()    
    
def heuristic_search(**kwargs):
    print('Non implemented yet')
    sys.exit()   
    
def search_more(**kwargs):
    one_solution = kwargs['initsol']
    incorrect = kwargs['parent']
    prior = kwargs['prior']
    #prior = [x for y in prior for x in y]
    notsubprior = subsumption.subsumes_program(prior, incorrect.support)
    if not notsubprior == True:
        notsubprior = notsubprior[1]
        notsubsol = subsumption.subsumes_program([one_solution],incorrect.support) 
        if not notsubsol == True:
            notsubsol = notsubsol[1]
            x = list(set(notsubprior).intersection(set(notsubsol)))
            if x != []:
                return True
            else:
                return False
        else:
            return False
    else:
        return False
    
def form_new_clauses(use_head_body_map,**kwargs):
    new = []
    for mapping in use_head_body_map:
        new_clause = []
        new_clause.append(gl.use_dict[mapping[0]])
        new_clause.extend([gl.use_dict[x] for x in mapping[1] ])
        #for x in mapping[1]:
        #    new_clause.append(gl.use_dict[x]) 
        new_clause = structs.Clause(new_clause,gl)
        if not 'incremental_kernel_search' in kwargs and not 'incremental_solve' in kwargs:
            update_support([new_clause]) # update support set of new clause
        new_clause.generatedAt = gl.current_example
        new.append(new_clause)
    return new    



def clear_prior():
    with open(gl.prior_theory_path,'w') as f:
        pass
    f.close()
    with open(gl.final_result_file,'w') as f:
        pass
    f.close()
    with open(gl.helper,'w') as f:
        pass
    f.close()

def raise_(ex):
    raise ex

def copylist(_list):
    return [x for x in _list]

def merge_prior():
    theory = gl.current_hypothesis
    if theory != {}:
        if all(x in theory for x in ['new','retained','specialized']):
            
            all_ = merge_all_lists([theory['new'],theory['retained'],theory['specialized']])
            gl.current_hypothesis = all_
            return all_
        else:
            print('Cannot unfold %s at update_support'%(theory))
            sys.exit()
    else:
        pass        

def merge_all_lists(list_of_lists):
    """ Does not flatten recursively, it just merges at the first level"""
    return [item for sublist in list_of_lists for item in sublist]



def update_support(theory,**kwargs):
    if isinstance(theory,dict):
        pass
    elif isinstance(theory,list) and theory != []:  
        if all(isinstance(x,structs.Clause) for x in theory): # then we need to find the kernel clauses subsumed by each clause in theory
            if gl.current_var_kernel != [] :
                var_kernel = gl.current_var_kernel
            elif 'simple_update' in kwargs and kwargs['simple_update']:
                generate_kernel(**kwargs)   
                var_kernel = gl.current_var_kernel 
            else:
                #raise_(excps.KernelSetNotFoundException('No Kernel Set!',gl.logger))
                return True        
            for c1 in theory:
                for c2 in var_kernel:
                    if add_to_support(c1,c2):
                        c1.support.append(c2)
        elif all(isinstance(x,list) for x in theory):
            y = [x for y in theory for x in y]
            return update_support(y,**kwargs)
        else:pass
    elif isinstance(theory,tuple): # then we need all x in c1 : c2 \preceq x for (c1,c2) in theory
        parent,ref = theory[0],theory[1]
        if isinstance(ref,list):
            for x in ref:
                for y in parent.support:
                    if subsumption.theta_subsumes(x.as_str_list,y.as_str_list) :
                        x.support.append(y)
        elif isinstance(ref,structs.Clause):
            for y in parent.support:
                if subsumption.theta_subsumes(ref.as_str_list,y.as_str_list) :
                    ref.support.append(y)     
        else:
            msg = 'Dont know what to do with this: %s update support (see supported types at utils.update_support)'(ref)
            raise excps.SupportSetException(msg,gl.logger)                        
    else: pass                                           

    
def add_to_support(add_to,to_add):
    t1 = subsumption.theta_subsumes(add_to.as_str_list,to_add.as_str_list)
    t2 = all(not subsumption.theta_subsumes(to_add.as_str_list,x.as_str_list) \
              for x in add_to.support) if add_to.support != [] else True
    return t1 and t2


def get_optimal_refinement(**kwargs):
    initsol = kwargs['initsol']
    parent = kwargs['parent']
    prior = kwargs['prior']
    # added below contains the as_string value for each clause added in refined.
    # It's used as set of 'keys' to filter duplicates  
    refined,added = [],[] 
    if 'search_space_size' not in kwargs: 
        for c in parent.support:
            use_dict = analyze_use_3(parent,c,prior)
            use_3 = asp.find_all_optimal()
            print(use_3)
            if use_3 != []:
                (_,revisable) = functs.filter_retained_(use_3,use_dict)
                for (clause_index,clause) in revisable:
                    revcl = functs.form_revised_(clause_index,clause,use_dict,use_3)
                    revcl = structs.Clause(revcl,gl)
                    #refined.append((clause,revcl))
                    if not revcl.as_string in added:
                        added.append(revcl.as_string)
                        refined.append(revcl)
            else: pass    
        if list(set(added)) == [initsol.as_string]:
            # then we have a problem: All we could find is the initial refinement
            # which does not subsume the support set. We'll try to split the initial
            # refinement. To do that, we repeat the above process, but this time we 
            # increase the size of the fragment of the support set that is used as 
            # search space. We do that calling this method again with an optional 
            # argument that specifies how many support clauses shall be used simultaneously
            # as search space: 
            kwargs.update({'search_space_size':'2'})
            return get_optimal_refinement(**kwargs)        
            # this is buggy (and doesn't fully work):
            # opt = subsumption.find_minimal_subsuming_subset(refined,parent.support,found_initial=True)
        else:        
            opt = subsumption.find_minimal_subsuming_subset(refined,parent.support)        
            update_support((parent,opt))
            return opt
    else:
        pass
        """ 
        
        BUGGY
        
        search_space_size = int(kwargs['search_space_size'])
        searchspace = itertools.combinations(parent.support, search_space_size)
        foundit = False
        for x in searchspace:
            dummy = structs.Clause(parent.as_str_list,gl) # this is an ugly patch in order for analyze_use_try to work
            dummy.support = list(x)
            use_dict = analyze_use_try([],[dummy],preserve=prior)
            use_3 = asp.find_all_optimal()  
            if use_3 != []:
                (_,revisable) = functs.filter_retained_(use_3,use_dict)
                for (clause_index,clause) in revisable:
                    revcl = functs.form_revised_(clause_index,clause,use_dict,use_3)
                    revcl = structs.Clause(revcl,gl)
                    #refined.append((clause,revcl))
                    if not revcl.as_string in added:
                        added.append(revcl.as_string)
                        refined.append(revcl)
            else: pass 
            opt = subsumption.find_minimal_subsuming_subset(refined,parent.support)        
            update_support((parent,opt))
            return opt
            """
    #return opt        
        
    
def analyze_use_try(kernel,previous_theory,**kwargs):
    """
    clause_level_search,support_level_search = False,False
    if 'clause_level_search' in kwargs and kwargs['clause_level_search']:
        clause_level_search = True
    if 'support_level_search' in kwargs and kwargs['support_level_search']:  
        support_level_search = True  
    """
    clause_count = 0
    use_dict = {}
    analyzed_kernel = []
    max_clause_length = 0
    for c in kernel:
        if len(c.body)+1 > max_clause_length : max_clause_length = len(c.body)+1 
        clause_count += 1
        (top_clause,try_clauses,use_dict) = analyze_use_try_clause(c,clause_count,use_dict,'kernel')
        analyzed_kernel.append(top_clause)
        analyzed_kernel.extend(try_clauses)
    analyze_prior_theory = []
    clause_count = 0
    for c in previous_theory:
        clause_count += 1
        support_clause_count = 0
        for sc in c.support:
            if len(sc.body)+1 > max_clause_length : max_clause_length = len(sc.body)+1 
            support_clause_count += 1
            (top_clause,exception_clauses,use_dict) = \
            analyze_use_try_clause(c,clause_count,use_dict,'previous_theory',sc,support_clause_count) 
            analyze_prior_theory.append(top_clause)
            analyze_prior_theory.extend(exception_clauses)
    
    optional = []
    #if 'preserve' in kwargs:  
    if False:    
        optional = [x.as_string_with_var_types for x in kwargs['preserve'] ]
    else:
        optional = analyzed_kernel 
    use2_choices = get_useatoms_choice_rules(kernel,use2=True)
    use3_choices = get_useatoms_choice_rules(previous_theory,use3=True) 
    optional = '\n'.join(optional) if optional != [] else ''  
    max_clauses = max(len(kernel),len(previous_theory))     
    if not 'incremental_search' in kwargs:     
        # Generate constraints and directives for heuristic search:
        # Minimize the total number of use/2 atoms, posNotCovered atoms and negsCovered atoms:
        posNotCoveredClauses = map(lambda x: "posNotCovered(%s) :-\n    example(%s), not %s."%(x,x,x),gl.example_patterns)
        negsCoveredClauses = map(lambda x: "negsCovered(%s) :-\n    %s, not example(%s)."%(x,x,x),gl.example_patterns)
        posNotCoveredAtoms = map(lambda x: "posNotCovered(%s)"%(x),gl.example_patterns)
        negsCoveredAtoms = map(lambda x: "negsCovered(%s)"%(x),gl.example_patterns)
        if gl.runargs["coverage"] == "heuristic": 
            content = '%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s'\
            %(optional, \
            '\n'.join(analyze_prior_theory), \
            'clauseIndex(1..%s).'%(str(max_clauses)), \
            'literalIndex(0..%s).'%(str(max_clause_length)), \
            use2_choices, \
            use3_choices, \
            '{use(I,J)}:-clauseIndex(I),literalIndex(J).', \
            '{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).', \
            '\n'.join(posNotCoveredClauses),\
            '\n'.join(negsCoveredClauses),\
            '#minimize{use(I,J),use(I,J,K),%s,%s}.'%(','.join(posNotCoveredAtoms),','.join(negsCoveredAtoms)), \
            ':- use(I,J), not use(I,0).', \
            '#hide.', \
            '#show use/2.', \
            '#show use/3.')
            
            # Also clear all other constraints:
            
            with open(gl.example_coverage_constr,'w') as f:
                pass
            
        else:  # perfect fit to the examples      
            content = '%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s'\
            %(optional, \
            '\n'.join(analyze_prior_theory), \
            'clauseIndex(1..%s).'%(str(max_clauses)), \
            'literalIndex(0..%s).'%(str(max_clause_length)), \
            use2_choices, \
            use3_choices, \
            '{use(I,J)}:-clauseIndex(I),literalIndex(J).', \
            '{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).', \
            '#minimize{use(I,J),use(I,J,K)}.', \
            ':- use(I,J), not use(I,0).', \
            '#hide.', \
            '#show use/2.', \
            '#show use/3.')
            
            # Also clear all other constraints:
            
    else:
        if kwargs['incremental_search']:
            if 'preserve' in kwargs: 
                prules = [x.as_string_with_var_types for x in kwargs['preserve'] ]
                optional = optional+'\n'+'\n'.join(prules)
                
            (coverschema,_) = generate_heuristic_exmplcov_constraints()
            content = '\n'.join(coverschema)+'\n\n'
            content = content+'%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s'\
            %(optional, \
            '\n'.join(analyze_prior_theory), \
            'clauseIndex(1..%s).'%(str(max_clauses)), \
            'literalIndex(0..%s).'%(str(max_clause_length)), \
            '{use(I,J)}:-clauseIndex(I),literalIndex(J).', \
            '{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).', \
            '#hide.', \
            '#show use/2.', \
            '#show use/3.','#show posCovered(N).','#show negsCovered(N).')     
    write_to_file(gl.indinp,content)  
    gl.use_dict = use_dict
    return use_dict     

def get_useatoms_choice_rules(program,**kwargs):
    choice_rules = []
    if 'use2' in kwargs:
        clause_count = 0
        for clause in program:
            clause_count += 1
            choice_rule = '{use(%s,%s..%s)}.'%(clause_count,'1',str(len(clause.body)))
            choice_rules.append(choice_rule)    
    elif 'use3' in kwargs:
        clause_count = 0
        for clause in program:
            sclause_count = 0
            clause_count += 1
            for sclause in clause.support:
                sclause_count += 1
                choice_rule = '{use(%s,%s,%s..%s)}.'%(str(clause_count),str(sclause_count),'1',str(len(sclause.body)))
                choice_rules.append(choice_rule)    
    else:
        pass
                        
    return ''.join(choice_rules)    
             
def generate_heuristic_exmplcov_constraints():
    coverschema,rejectschema = [],[]
    negs_minimize = ','.join(['%s:not example(%s)'%(x,x) for x in gl.example_patterns])
    negs_covered_clause = 'negsCovered(N) :- N = #count{%s}.\n'%(negs_minimize)
    negs_minimize_statement = '#minimize{%s}.'%(negs_minimize)
    pos_minimize = ','.join(['not %s:example(%s)'%(y,y) for y in gl.example_patterns])
    pos_covered_clause = \
    'posCovered(N) :- N = #count{%s}.\n'%(','.join(['%s:example(%s)'%(z,z) for z in gl.example_patterns]))
    minimize_statement = '#minimize{%s,%s,%s}.\n'%(\
                          pos_minimize,negs_minimize,\
                          'use(I,J),use(I,J,K)')    
    coverschema.extend([minimize_statement,
                        pos_covered_clause,
                        negs_covered_clause])
    rejectschema.extend([negs_minimize_statement,negs_covered_clause,'#show negsCovered(N).'])
    return (coverschema,rejectschema)

def analyze_use_3(clause,support_clause,retained):
    (top_clause,exception_clauses,use_dict) = analyze_use_try_clause(clause,1,{},'previous_theory',support_clause,1) 
    #analyze_prior_theory.append(top_clause)
    #analyze_prior_theory.extend(exception_clauses)
    x1 = '\n'.join([x.as_string_with_var_types for x in retained])
    x2 = top_clause
    x3 = '\n'.join(exception_clauses)
    x4 = 'clauseIndex(1).'
    x5 = 'literalIndex(0..%s).'%(str(len(support_clause.body)+1))
    x6 = '{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).'
    x7 = '#minimize{use(I,J,K):clauseIndex(I):clauseIndex(J):literalIndex(K)}.'
    x8 = '#hide.'
    x9 = '#show use/3.'
    content = '\n\n'.join([x1,x2,x3,x4,x5,x6,x7,x8,x9])
    write_to_file(gl.indinp,content)
    return use_dict
    

def analyze_use_try_clause(clause,clause_count,use_dict,flag,*support_info):
    try_list,try_clauses,var_types = [],[],[]
    if flag == 'kernel':
        head_use_atom = 'use(%s,0)'%(str(clause_count))
        use_dict.update({head_use_atom:clause.head})
        body_lit_count = 0
        for lit in clause.body:
            body_lit_count += 1
            use_atom = 'use(%s,%s)'%(str(clause_count),str(body_lit_count))
            use_dict.update({use_atom:lit})
            lit_vars = ','.join([x for x in lit.terms_types_map])
            try_atom = 'try(%s,%s,vars(%s))'%(str(clause_count),str(body_lit_count),lit_vars)
            try_list.append(try_atom)
            #_var_types = ['%s(%s)'%(functs.de_sign(lit.terms_types_map[key]),key) for key in lit.terms_types_map ]
            _var_types = get_var_types_(lit)
            var_types.extend(_var_types)
            try_use_clause = '%s :- %s,%s,%s.'%(try_atom,use_atom,lit.as_string,','.join(_var_types))
            try_not_use_clause = '%s :- not use(%s,%s),%s.'%(try_atom,str(clause_count),str(body_lit_count),','.join(_var_types))
            try_clauses.extend([try_use_clause,try_not_use_clause])
        top_clause = '%s :- %s,%s,%s.'%(clause.head.as_string,head_use_atom,','.join(try_list),','.join(set(var_types)))   
    if flag == 'previous_theory':
        support_clause = support_info[0]
        support_clause_count = support_info[1]
        i,j = clause_count,support_clause_count
        use_dict.update({'specialize(%s)'%(str(clause_count)):clause})  
        var_types = get_var_types_(clause.body)
        h_var_types = get_var_types_(clause.head)
        var_types.extend([x for x in h_var_types if not x in var_types])    
        exception_atom = 'expt(%s,%s)'%(str(clause_count),clause.head.as_string)
        if clause.body != []:
            top_clause = '%s :- %s,not %s,%s.'%(clause.head.as_string,','.join([x.as_string for x in clause.body]),exception_atom,\
                                          ','.join(var_types))
        else:
            top_clause = '%s :- not %s,%s.'%(clause.head.as_string,exception_atom,\
                                          ','.join(var_types))   
        exception_clauses = []
        k = 0
        for lit in support_clause.body:
            if lit.as_string not in clause.as_str_list:
                k += 1
                _var_types = get_var_types_(lit)
                _var_types.extend([x for x in h_var_types if not x in _var_types])
                use_3_atom = 'use(%s,%s,%s)'%(str(i),str(j),str(k))
                use_dict.update({use_3_atom:lit})
                expclause = '%s :- %s,not %s,%s.'%(exception_atom,use_3_atom,lit.as_string,','.join(_var_types))
                exception_clauses.append(expclause)        
        try_clauses = exception_clauses 
    return (top_clause,try_clauses,use_dict)    

def get_var_types_(lit):
    var_types = []
    if isinstance(lit,structs.Literal):
        var_types = ['%s(%s)'%(functs.de_sign(lit.terms_types_map[key]),key) for key in lit.terms_types_map ]
    elif isinstance(lit,list):
        _var_types = flatten([['%s(%s)'%(functs.de_sign(_lit.terms_types_map[key]),key) for key in _lit.terms_types_map ] for _lit in lit])
        var_types = set(_var_types)
    else:
        msg = 'You can ask for the types of variables of a Literal or a list of Literals. You asked for %s'%(lit)
        raise excps.VariableTypesException(msg,gl.logger)         
    return list(var_types)
   
def generate_kernel(**kwargs):
    delta_set = get_delta(**kwargs)
    kernel_set = get_kernel_set(delta_set)
    variabilize_kernel(kernel_set) # stores the generated kernel in core's globals   
   
def variabilize_theory(theory):
    return variabilize_kernel(theory,'debug=yes')

def variabilize_kernel(kernel_set,*debug):
    clauses = []
    for c in kernel_set:
        _c = variabilize_clause(c)
        clauses.append(_c)
    if len(debug) == 0:     
    #if True:     
        write_to_file(gl.var_kernel_path,'\n\n'.join(map(lambda x: x.as_string,clauses)))    
        gl.current_var_kernel = clauses
    return clauses        

def variabilize_clause(clause,**all_plmrks):
    
    """ Variabilize a clause based on mode declaration schemas that match each of its literals.
        The optional parameter all_plmrks specifies if only terms that correspond to input and
        output placemarkers will be variabilized (as in common ILP), or if all terms that 
        correspond to a placemarker will be variabilized. The latter is used to fully variabilize
        and then skolemize a clause when checking for theta-subsumption with a ground subsumee clause.  """
        
    if not isinstance(clause, structs.Clause):
        if isinstance(clause, list):
            c = structs.Clause(clause,gl)
            return variabilize_clause(c,**all_plmrks)
        else:
            raise excps.TypeException('Tried to variabilize a non-clause term!',gl.logger)            
    else:
        var_lits = []
        (vhead,used_vars_map,var_count,used_vars) = \
            variabilize_clause_literal(clause.head,{},0) if all_plmrks == {} else \
                variabilize_clause_literal(clause.head,{},0,all_plmrks = True)
        types = get_var_types(used_vars,used_vars_map,clause.head.terms_types_map)
        var_lits.append({'literal':vhead,
                          'var_types_map':types,
                          'subsuming_mode':clause.head.subsuming_mode})
        for lit in clause.body:
            (vbodylit,used_vars_map,var_count,used_vars) = \
            variabilize_clause_literal(lit,used_vars_map,var_count) if all_plmrks == {} else \
                variabilize_clause_literal(lit,used_vars_map,var_count,all_plmrks = True)
            types = get_var_types(used_vars,used_vars_map,lit.terms_types_map)
            var_lits.append({'literal':vbodylit,
                             'var_types_map':types,
                             'subsuming_mode':lit.subsuming_mode})
    varcl = structs.Clause([],gl,var_lits)
    return varcl       
            
def get_var_types(used_vars,used_vars_map,terms_types_map):
    out_dict = {}
    for var in used_vars:
        replaced_term = None
        for term in used_vars_map:
            if used_vars_map[term] == var:
                replaced_term = term
                break
        out_dict.update({var:terms_types_map[replaced_term]})
    return out_dict            
                        
            
def variabilize_clause_literal(lit,used_vars_map,var_count,**all_plmrks):
    _lit = lit.as_string
    if all_plmrks == {}:
        symlist = ['+','-'] # variabilize input or output placemarkers only:
    else:
        if all_plmrks['all_plmrks']:
            symlist = ['+','-','#'] # variabilize each term that corresponds to a placemarker:       
    
    to_be_varbed = {k:lit.terms_types_map[k] for k in lit.terms_types_map if any(x in lit.terms_types_map[k] for x in symlist)}
    vars_actually_used = []
    vars_terms_map = {} 
    for key in to_be_varbed:
        var = None
        if key in used_vars_map: 
            var = used_vars_map[key]
        else:
            var_count += 1
            var = 'X'+str(var_count)
            used_vars_map[key] = var 
        #_lit = _lit.replace(key,var)
        vars_actually_used.append(var)
        vars_terms_map.update({key:var})
    _lit = subsumption._substitute(functs.parse(_lit), vars_terms_map, [])    
    return (_lit,used_vars_map,var_count,vars_actually_used) 

    """
    vars_actually_used = []
    for key in to_be_varbed:
        var = None
        if key in used_vars_map: 
            var = used_vars_map[key]
        else:
            var_count += 1
            var = 'X'+str(var_count)
            used_vars_map[key] = var 
        _lit = _lit.replace(key,var)
        vars_actually_used.append(var)
    return (_lit,used_vars_map,var_count,vars_actually_used)     
    """

def get_kernel_set(delta_set):
    #print(delta_set)
    kernel = []
    for atom in delta_set:
        c = get_kernel_clause(atom,delta_set)
        #print(c.as_string)
        kernel.append(c)
    #import json    
    kl = '\n\n'.join([c.as_string for c in kernel])
    gl.logger.info('[@EXMPL %s:] Found new Kernel Set'%(str(gl.current_example)))
    write_to_file(gl.kernel_path,kl)   
    gl.current_kernel = kernel
    return kernel 

def get_kernel_clause(atom,delta_set):
    if delta_set != []:
        indict = get_head_in_terms(atom)
        modebs = gl.modeb
        kernel_body = []
        for i in range(0,gl.vardepth):
            body_lits = [functs.replace_body_decl(indict,b) for b in modebs]
            with open(gl.dedinp,'w') as f:
                f.write(''.join(map(lambda x: '%s.\n'%(x),delta_set)))
                f.write('#hide.\n')
                f.write(''.join(map(lambda x: '#show %s.\n'%(x),body_lits)))
            f.close() 
            res = asp.ded()
            #print(res)
            kernel_body.extend([x for x in res if x not in kernel_body])   
        kernel_clause = prepend(atom,kernel_body)    
        #print(kernel_clause)
        return structs.Clause(kernel_clause,gl)
        #return None
    else: pass    
    
def prepend(x,y):
    y.reverse()
    y.append(x)
    y.reverse()
    return y

def get_delta(**kwargs):
    model_count,maxtries,directives = 0,1000,[]
    #gl = core.core().globals
    #gl = core.global_vals
    modehs = gl.modeh
    for mode in modehs:
        mmode = mode 
        inplmrk = get_in_plmrk(mode)
        outplmrk = get_out_plmrk(mode)
        conplmrk = get_gr_plmrk(mode)
        alll = flatten([inplmrk,outplmrk,conplmrk])
        varcount = 0
        for x in alll:
            mmode = mmode.replace(x,'X'+str(varcount),1) # always replace only the first occurrence 
            varcount += 1
        alll = map(functs.de_sign,alll)
        vv = ['X'+str(i) for i in range(0,len(alll))]
        d = dict(zip(vv,alll))    
        g = lambda k,v: '%s(%s)'%(v,k)
        types = [g(k,d[k]) for k in d]
        types.append(mmode)
        types.reverse()
        t = ':'.join(types)
        directives.append(t)
    # abductive search   
    model_count += 1
    write_abd_directives(directives,model_count)
    model = asp.abd(**kwargs)
    if model != ['UNSATISFIABLE']:
        gl.logger.info('[@EXMPL %s] Found delta set: %s'%(str(gl.current_example),model))    
        gl.current_delta = model    
        return model
    else:
        while functs.aspunsat(model) and model_count <= maxtries:    
            model_count += 1
            gl.logger.info('[@EXMPL %s:] Trying to find delta set of size %s'%(str(gl.current_example),str(len(directives)*model_count)))
            write_abd_directives(directives,model_count)
            model = asp.abd(**kwargs)
        if model_count == maxtries and functs.aspunsat(model) :
            msg = 'Failed to find delta set, exhausted maxtries=%s'%(maxtries)
            raise excps.DeltaSetException(msg,gl.logger)
        gl.logger.info('[@EXMPL %s] Found delta set: %s'%(str(gl.current_example),model))    
        gl.current_delta = model    
        return model    
       
        
"""
def write_abd_directives(directives,model_count):
    g = lambda x: '0{%s}%s.\n'%(x,str(model_count))
    k = lambda x: '#show %s.'%(x)
    show_directives = [x.split(':')[0] for x in directives]
    with open(gl.abdinp,'w') as f:
        f.write(''.join(map(g,directives)))
        f.write('#hide.\n')
        f.write('\n'.join(map(k,show_directives)))
    f.close()    
"""
    
def write_abd_directives(directives,model_count):
    varmodes = gl.modeHsvarbed
    minimize = "#minimize{ %s }.\n\n"%(",".join(varmodes))
    show = map(lambda x: "#show %s."%(x),varmodes)
    g = lambda x: '{%s}.\n'%(x)
    #k = lambda x: '#show %s.'%(x)
    #show_directives = [x.split(':')[0] for x in directives]
    with open(gl.abdinp,'w') as f:
        f.write(''.join(map(g,directives)))
        f.write(minimize)
        f.write('#hide.\n\n')
        f.write('\n'.join(show))
    f.close() 
    

def get_head_in_terms(atom):
    modes = gl.modeh
    out = []
    for m in modes:
        out.extend(functs.plm_pattern(m, '+'))
    with open(gl.ground,'w') as f:
        f.write('%s.\n\n'%(atom))
        f.write(''.join(map(lambda (x,y): '{term(X,%s):%s}.\n'%(y,x),out)))
        f.write('#hide.\n')
        f.write('#show term/2.\n')
    f.close()   
    out = asp.ground()     
    k = [functs.determ(x) for x in out]    
    return {x[0]:x[1] for x in k}
"""
def get_terms_types_map(atom,search_patterns):
    out = []
    with open(gl.ground,'w') as f:
        f.write('%s.\n\n'%(atom))
        f.write(''.join(map(lambda (x,y): '{term(X,%s):%s}.\n'%(y,x),out)))
        f.write('#hide.\n')
        f.write('#show term/2.\n')
    f.close()   
    out = asp.ground()     
    k = [functs.determ(x) for x in out]    
    return {x[0]:x[1] for x in k}
"""


def get_in_plmrk(mode):
    p = '\+[A-Za-z0-9_]+'
    m = re.findall(p,mode)
    if m:
        return m
    else:
        return []
    
def get_out_plmrk(mode):
    p = '\-[A-Za-z0-9_]+'
    m = re.findall(p,mode)
    if m:
        return m
    else:
        return []    
    
def get_gr_plmrk(mode):
    p = '\#[A-Za-z0-9_]+'
    m = re.findall(p,mode)
    if m:
        return m
    else:
        return []      

class Example:
    
    def __init__(self,index,has_positives,poscount):
        self.idex = index
        self.has_positives = has_positives 
        self.positive_count = poscount

def get_example(index):
    #gl = core.core().globals
    #gl = core.global_vals
    has_positives = False
    try:
        cursor = gl.db.examples.find({'example':index})
        pos = cursor[0]['pos']
        nar = cursor[0]['nar']
        """
        positives = [str(x) for y in pos for x in y]
        narrative = [str(x) for y in nar for x in y]
        """
        positives = [str(x) for x in pos]
        narrative = [str(x) for x in nar]
    
        #print('found one!')
        
        ex = open(gl.examples,'w')
        if positives != []:
            ex.write('%% positives:\n\n')
            ex.write('\n'.join(map(lambda x: 'example(%s).'%(x),positives)))
            ex.write('\n\n')
            has_positives = True
        if narrative != []:
            ex.write('%% narrative:\n\n')
            ex.write('.\n'.join(narrative))  
            ex.write('.\n\n')
        """
        if previous != []:
            ex.write('%% initiated previously and still hold :\n\n')
            ex.write('\n'.join(map(lambda x: 'example(%s).'%(x),previous)))
            ex.write('\n')    
            ex.write('.\n'.join(previous)) 
            ex.write('.\n')
        """    
        e = Example(index,has_positives,len(positives))
        gl.current_example_object = e
        return True
    except IndexError:
        return False
    
def crossval(theory_file,examples,**kwargs):
    
    """ theory_file is a file with a hypothesis we want to evaluate and
        examples is a SET OF INTEGERS denoting examples ids in a db. """
    showstats = False
    if 'show_stats' in kwargs and kwargs['show_stats']:
        showstats = True    
    patterns = gl.example_patterns 
    crossvalpath = gl.crossval_path
    with open(crossvalpath,'w') as f:
        testcount = 0
        tp_pool,fp_pool,fn_pool = [],[],[]
        for p in patterns:
            testcount += 1
            c1 = 'tp%s(N) :- N = #count{example(%s):%s}, N > 0.'%(testcount,p,p)
            f.write(c1+'\n')
            tp_pool.append(c1.split(':-')[0].strip())
            c2 = 'fp%s(N) :- N = #count{%s:not example(%s)}, N > 0.'%(testcount,p,p)
            f.write(c2+'\n')
            fp_pool.append(c2.split(':-')[0].strip())
            c3 = 'fn%s(N) :- N = #count{example(%s):not %s}, N > 0.'%(testcount,p,p)
            f.write(c3+'\n')
            fn_pool.append(c3.split(':-')[0].strip())  
        f.write('positives(N) :- N = #count{example(_)}, N > 0.\n')
        f.write('#hide.\n')
        for x in tp_pool:
            f.write('#show %s.\n'%(x))
        for x in fp_pool:
            f.write('#show %s.\n'%(x))
        for x in fn_pool:
            f.write('#show %s.\n'%(x))
        f.write('#show positives/1.\n')            
    f.close()
    tps = fps = fns = positives = 0
    for i in examples:
        if get_example(i):
            print(i)
            options = [asp.clingo,asp.bk,asp.ex,theory_file,crossvalpath,'0', '--asp09']
            command = ' '.join(options)
            out = os.popen(command).read().splitlines()
            if out != []:
                stop = 'stop'
            #out = [x.strip() for x in out if not x.strip() == '']
            #out = [x.split('.')[0] for x in out]
            
            out = os.popen(command).read().split('.')
            out = [x.strip() for x in out if not x.strip() == '']
            
            for atom in out:
                value = int(re.findall('\(\d+\)',atom)[0].split('(')[1].split(')')[0])
                if 'tp' in atom:
                    tps += value
                elif 'fp' in atom:
                    stop = 'stop'
                    fps += value
                elif 'fn' in atom:
                    fns += value 
                else:
                    positives += value           
         
            #print(out)
            
    print('all pos: %s, tp: %s, fp: %s, fn: %s')%(positives,tps,fps,fns)        
    #print(tps,fps,fns)        
            

#crossval(asp.test_theory,range(0,99990))
if __name__ == "__main__":
    #crossval(asp.test_theory,range(0,99990))
    crossval(asp.test_theory,range(0,4000))        
    
    
    
    
def get_from_cursor(cursor):
    pos,nar,innert = [],[],[]
    f = lambda x: False if x.strip() == '' else True
    try:
        for x in cursor:
            pos.append(x['pos'])
            nar.append(x['nar'])
         
        pos = [str(x) for y in pos for x in y]
        nar = [str(x) for y in nar for x in y] 
        #pos = set(filter(f,flatten([z.split('@') for z in filter(f,[str(x) for x in pos]) ])))
        #nar = set(filter(f,flatten([z.split('@') for z in filter(f,[str(x) for x in nar]) ])))
        
    except IndexError:
        #exists = False
        pass
    pos,nar = list(pos),list(nar)
    #print(pos,nar,innert)  
    return (pos,nar)      
    
def isint(inp):
    try:
        int(inp)
        return True
    except ValueError:
        return False
            
def get_time_step(gl):
    exmpl_up_to = gl.db.examples.count()
    p = '_[0-9]+'
    m = re.findall(p,gl.db_name)
    if m:
        return (int(m[0].split('_')[1]),exmpl_up_to)
    else:
        return (1,exmpl_up_to)     
    
def write_to_file(_file,msg):
    with open(_file,'w') as f:
        f.write(msg)
    f.close()        
    
def post_exmpl_constraints(**kwargs):
    scs,cls,hs = kwargs['set_cover_search'],kwargs['clause_level_search'],kwargs['heuristic_search']
    heuristic = scs or cls or hs 
    covfile,rejectfile = gl.example_coverage_constr,gl.example_reject_constr
    if not heuristic: 
        covconstr,rejconstr = gl.example_constraints_cover,gl.example_constraints_reject  
    else:
        covconstr,rejconstr = gl.heuristic_example_constraints_cover,gl.heuristic_example_constraints_reject     
    covcontent = '\n'.join(covconstr)
    rejcontent = '\n'.join(rejconstr)
    write_to_file(covfile,covcontent)
    write_to_file(rejectfile,rejcontent)
    

    
    
def see(P,**kwargs):
    """ For debugging only """
    output = 'Not supported input type'
    if isinstance(P,list):
        if all(isinstance(x,structs.Clause) for x in P):
            output = '\n'.join([x.as_string for x in P])
        elif all(isinstance(x,basestring) for x in P):
            output = '\n'.join([x for x in P])
        elif all(isinstance(x,tuple) for x in P):
            #for x in P:
            #    print([x[i] for i in len(x)])
            pass  
        else:
            pass
    elif isinstance(P,structs.Clause):
        output = P.as_string
    elif isinstance(P,tuple):
        #print('tuple:',[x[i] for i in len(x)]) 
        pass  
    else: pass
    if 'w' in kwargs and kwargs['w']:
        return output  
    else:
        print(output)                                    
    
def updateprior(new,retained,refined):
    f = lambda x: x.as_string_with_var_types    
    #_new = [x for x in new if not x in retained and not x in refined]
    #_refined = refined.values()
    n = '\n\n'.join(map(f,new))
    r = '\n\n'.join(map(f,retained))
    s = '\n\n'.join(map(f,refined))
    x = '%s\n\n%s\n\n%s'%(n,r,s)
    write_to_file(gl.prior_theory_path,x)
    m = [x for y in [new,retained,refined] for x in y]
    m = see(m,w=True)
    write_to_file(gl.final_result_file,m)
        
    
def tideup(newclauses,retained,specialized,**kwargs):
    if 'kernel' in kwargs:
        gl.current_var_kernel = []
    if 'usedict' in kwargs:
        gl.use_dict = {}
    if 'updatexmpl' in kwargs:
        gl.seen_examples.append(kwargs['updatexmpl'])
    if 'delta' in kwargs:
        gl.current_delta = []    
    """
    f = lambda x: x.as_string_with_var_types    
    n = '\n\n'.join(map(f,newclauses))
    r = '\n\n'.join(map(f,retained))
    s = '\n\n'.join(map(f,specialized))
    x = '%s%s%s'%(n,r,s)
    write_to_file(gl.prior_theory_path,x)
    """                  
    





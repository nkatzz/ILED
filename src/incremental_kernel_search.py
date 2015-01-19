'''
Created on Jul 27, 2014

@author: nkatz
'''

def incremental_search(**kwargs):
    import utils,core,asp,functs,excps
    gl = core.global_vals
    gl.use_dict = {}
    is_new_example = kwargs['is_new_example'] 
    retained,new,refined = kwargs['retcl'],kwargs['newcl'],kwargs['refcl']
    prior_theory = [x for y in [retained,new,refined] for x in y]
    target_score = gl.current_example_object.positive_count
    if is_new_example:
        utils.generate_kernel(**kwargs)
        # revise the clauses in the prior theory one by one first
        for c in prior_theory: # TODO
            pass
        var_kernel = gl.current_var_kernel 
        # =====================================
        generate_all_seed_rules(var_kernel,gl)
        # =====================================
        found_solution = False
        #current_opt_score = float('Inf')
        #pos_covered = 0
        #negs_covered = float('Inf')
        best_score = 0
        tried_seed_rules = []
        while not found_solution: 
            partial_rules,tried_kernel_clauses = [],[]
            kernel_loop_counter = 0
            for c in var_kernel:
                if 'terminatedAt' in c.as_string:
                    stop = 'stop'
                tried_kernel_clauses.append(c)
                partial_rules.append(c)
                utils.analyze_use_try(partial_rules,[],incremental_search=True) 
                if kernel_loop_counter == 0:
                    (model,seed_rule,pos,negs,optimization_score) = get_seed_rule(tried_seed_rules,
                                                                                  var_kernel,gl)
                    tried_seed_rules.append(seed_rule)
                    
                    print('New seed rules: ')
                    for r in tried_seed_rules: 
                        print(r.as_string)
                else:  
                    (model,pos,negs,optimization_score) = asp.ind(kernel_generalization=True,
                                                                  incremental_search=True) 
                partial_rules.extend(tried_seed_rules)           
                #(all_solutions,pos,negs) = asp.ind(find_all_optimal=True,
                #                           incremental_search=True,
                #                           opt=optimization_score)
                #new_score = pos - negs - average_size(all_solutions)
                new_score = pos - negs - average_size_(model)
                if new_score > best_score:
                    best_score = new_score
                print('pos,negs,average_size,best_score: ',pos,negs,average_size_(model),best_score)
                #if pos >= pos_covered and negs <= negs_covered:
                if False:
                    pos_covered,negs_covered = pos,negs
                else:
                    # At this point, including any one solution from all_solutions reduces
                    # the current score. Hence, we will use one such solution as a new 
                    # addition and search each tried kernel clause again, in order to retrieve
                    # the previous score (or even improve it)
                    #new_addition,added = [],[]
                    """
                    for solution in all_solutions:
                        if len(solution) > 1:
                            (use_2,_) = functs.split_use_2_3(solution)
                            (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                            if ok :
                                new = utils.form_new_clauses(use_head_body_map,incremental_kernel_search=True)
                                for n in new:
                                    if not n.as_string in added: 
                                        new_addition.append(n)
                                        added.append(n.as_string) 
                    """       
                
                    (use_2,_) = functs.split_use_2_3(model)
                    new = []
                    if len(use_2) > 1:
                        (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                        if ok :
                            new = utils.form_new_clauses(use_head_body_map,incremental_kernel_search=True)
                        #new_addition.extend(new)
                              
                    old_use_dict,improvedit = gl.use_dict,False      
                    for c_ in tried_kernel_clauses:
                        partial_rules_copy = [rule for rule in partial_rules if rule != c]
                        partial_rules_copy.extend(new) 
                        partial_rules_copy.append(c_)
                        utils.analyze_use_try(partial_rules_copy,[],incremental_search=True)  
                        (model_,pos,negs,optimization_score) = asp.ind(kernel_generalization=True,
                                                                  incremental_search=True)
                        #(lastmodel,optimization_score) = asp.ind(kernel_generalization=True,incremental_search=True) 
                        #(pos,negs,_,_,_) = get_score(lastmodel,target_score)
                        #(all_solutions_,pos,negs) = asp.ind(find_all_optimal=True,
                        #                                   incremental_search=True,
                        #                                   opt=optimization_score)      
                        #if pos >= pos_covered and negs <= negs_covered:
                        new_score = pos - negs - average_size_(model_) 
                        if new_score > best_score:
                            #all_solutions = all_solutions_ 
                            model = model_
                            best_score = new_score
                            improvedit = True
                            print('improved it!')
                        
                            #break
                    if not improvedit:
                        gl.use_dict = old_use_dict        
                    """
                    if not improvedit:
                        gl.use_dict = old_use_dict
                    if pos < pos_covered:  
                        pos_covered = pos
                    if negs > negs_covered:
                        negs_covered = negs
                    """         
                #if optimization_score != current_opt_score:
                if True:    
                    new_partial_rules,added = [],[]
                    #for solution in all_solutions:
                    for solution in [model]:    
                        if len(solution) > 1:
                            (use_2,use_3) = functs.split_use_2_3(solution)
                            (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                            if ok :
                                new = utils.form_new_clauses(use_head_body_map,incremental_kernel_search=True)
                                for c in new:
                                    if not c.as_string in added: 
                                        new_partial_rules.append(c)
                                        added.append(c.as_string)
                            else:
                                msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
                                raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
                    partial_rules = new_partial_rules
                    tried_kernel_clauses.extend(partial_rules)
                    stop = 'stop'
                kernel_loop_counter += 1
            if False:
                found_solution = True                
        else:
            pass
    
def get_seed_rule(tried_seed_rules,kernel_set,gl):
    import utils,asp,functs,excps
    seed_model,seed_rule,found_seed = None,None,False
    str_tried_seed_rules = [r.as_string for r in tried_seed_rules]
    for c in kernel_set:
        utils.analyze_use_try([c],[],incremental_search=True)  
        (_,pos,negs,optimization_score) = asp.ind(kernel_generalization=True,
                                                      incremental_search=True)  
        (all_solutions,_,_) = asp.ind(find_all_optimal=True,
                                       incremental_search=True,
                                       opt=optimization_score)
        for solution in all_solutions:    
            if len(solution) > 1:
                (use_2,_) = functs.split_use_2_3(solution)
                (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                if ok :
                    new = utils.form_new_clauses(use_head_body_map,incremental_kernel_search=True)
                    if not new[0].as_string in str_tried_seed_rules: 
                        seed_model = use_2
                        seed_rule = new[0]
                        found_seed = True
                        break
                else:
                    msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
                    raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
        if found_seed:
            break
    return (seed_model,seed_rule,pos,negs,optimization_score)            
             
    
def generate_all_seed_rules(kernel_set,gl):
    import utils,asp,functs,excps
    generated_seeds,str_generated_seeds = [],[]
    for c in kernel_set:
        for seed in generated_seeds:
            utils.analyze_use_try([c],[],incremental_search=True,preserve=generated_seeds)  
            (_,pos,negs,optimization_score) = asp.ind(kernel_generalization=True,
                                                      incremental_search=True)  
            (all_solutions,_,_) = asp.ind(find_all_optimal=True,
                                       incremental_search=True,
                                       opt=optimization_score)
            for solution in all_solutions:    
                if len(solution) > 1:
                    (use_2,_) = functs.split_use_2_3(solution)
                    (ok,use_head_body_map) = functs.head_body_use_atoms_filter(use_2)
                    if ok :
                        new = utils.form_new_clauses(use_head_body_map,incremental_kernel_search=True)
                        if not new[0].as_string in str_generated_seeds: 
                            generated_seeds.append(new[0])
                            str_generated_seeds.append(new[0].as_string)
                    else:
                        msg = 'Found a solution use(i,j) atom with no corresponding use(i,0) atom'
                        raise excps.Use_2_HeadNotAbducedException(msg,gl.logger)
            print('seeds:')
            utils.see(generated_seeds)
    #return (seed_model,seed_rule,pos,negs,optimization_score)            
    return generated_seeds    
    
def generate_seeds(generated_seeds,str_generated_seeds):
    pass    
    
def average_size(solutions):
    ac = 0
    for sol in solutions:
        ac = ac + len(sol)
    return float(ac)/float(len(solutions))            
   
def average_size_(solution):
    return len(solution)    
    
def get_score(atoms,target_score):
    pos,negs,use_atoms_count = 0,0,0
    for x in atoms:
        if 'posCovered' in x:
            pos = int(x.split('posCovered(')[1].split(')')[0])
        elif 'negsCovered' in x:
            negs = int(x.split('negsCovered(')[1].split(')')[0])
        elif 'use' in x:
            use_atoms_count += 1
    score = pos - negs - use_atoms_count
    optimization_score = target_score - pos + negs + use_atoms_count   
    return (pos,negs,use_atoms_count,optimization_score,score)    
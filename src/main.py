'''
Created on Jul 2, 2014

@author: nkatz
'''
import core
import utils as u
import asp
import utils
import sys
import argparse


gl = core.global_vals


def learn(**kwargs):
    u.clear_prior()
    found_new_clauses = False
    hs,scs,cls,incsolve = False,False,False,False
    (step,up_to_exmpl) = utils.get_time_step(gl)
    time_interval = (i for i in range(0,up_to_exmpl*step+1,step) )
    (newclauses,retained,specialized) = ([],[],[])
    if 'heuristic_search' in kwargs and kwargs['heuristic_search'] : hs = True 
    if 'set_cover_search' in kwargs and kwargs['set_cover_search'] : scs = True
    if 'clause_level_search' in kwargs and kwargs['clause_level_search'] : cls = True
    if 'incremental_solve' in kwargs and kwargs['incremental_solve'] : incsolve = True
    u.post_exmpl_constraints(heuristic_search=hs,set_cover_search=scs,clause_level_search=cls)
    
    """
    for i in range(1,600):
        if utils.get_example(i):
            gl.current_example = i
            #if not asp.test_hypothesis():
            print(i)
            asp.show_negs()
    print('here')
    """
    
    #for i in time_interval:
    #for i in range(1,100000):
    for i in range(1,1000000):    
        if i == 1672:
            stop = 'stop'
        if utils.get_example(i):
            gl.current_example = i
            if not asp.test_hypothesis():
                print(i)
                print('revising')
                (newclauses,retained,specialized) = \
                          u.revise(is_new_example=True,
                                   debug=False,
                                   newcl=newclauses,
                                   refcl=specialized,
                                   retcl=retained,heuristic_search=hs,
                                   set_cover_search=scs,
                                   clause_level_search=cls,
                                   incremental_solve=incsolve)
                found_new_clauses = newclauses != [] 
            else:
                print(i)
                print('correct')
                if gl.current_example_object.has_positives:
                    u.update_support([newclauses,
                                      retained,
                                      specialized],
                                      simple_update=True)
                                          
            if found_new_clauses:
                for j in gl.seen_examples:
                    utils.get_example(j)
                    if not asp.test_hypothesis():
                        (newclauses,retained,specialized) = \
                        u.revise(is_new_example=False,
                                 debug=False,
                                 newcl=newclauses,
                                 refcl=specialized,
                                 retcl=retained,heuristic_search=hs,
                                 set_cover_search=scs,
                                 clause_level_search=cls,
                                 incremental_solve=incsolve) 
                    else: pass  
            u.tideup(newclauses,retained,specialized,
                     kernel='clear',delta='clear',
                     usedict='clear',updatexmpl=i)                       
            found_new_clauses = False
        
def batchMode():
    u.clear_prior()
    u.post_exmpl_constraints(heuristic_search=False,set_cover_search=False,
                             clause_level_search=False)
    (newclauses,retained,specialized) = ([],[],[])
    (newclauses,retained,specialized) = \
                    u.revise(is_new_example=True,
                    debug=False,
                    newcl=newclauses,
                    refcl=specialized,
                    retcl=retained,heuristic_search=False,
                    set_cover_search=False,
                    clause_level_search=False,
                    incremental_solve=False) 
     print('\nTheory:\n')
     u.see(newclauses)  
        
        
if __name__ == "__main__":
    #core.parseargs()
    #args = sys.argv[1:]    
    #if args != []:
    args = dict(x.split('=', 1) for x in sys.argv[1:])
    
    if 'newdb' in args:
        gran_ = int(args['newdb'])
        core.generate_db(db='caviar-synthetic',gran=gran_)
    if 'heuristic_search' in args and args['heuristic_search']:
        learn(heuristic_search=True)  
    elif 'clause_level_search' in args and args['clause_level_search']:
        learn(clause_level_search=True) 
    elif 'mode' in args: # demo=caviar or demo=ctm
        if args['mode'] == 'batch':
            batchMode()
    else:    
        learn()
        #print('What you want to do?')    
    #if 'set_cover_search' in args and args['set_cover_search']:
    #    learn(set_cover_search=True)
    #else:
    #    learn(set_cover_search=False)         









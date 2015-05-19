'''
Created on Jul 2, 2014

@author: nkatz
'''
import core
import utils as u
import asp
import utils
import sys
#import argparse

"""
To Do:

1. Pass args to the main learning function:
  - DB name
  - Granularity ?
  - example pattern
  - running modes? (experiments, sequential run, runs on randomly exmaples...)
  
2. Implement support update as in paper (hopefully this will fix all remaining 
   support set problems)  

3. Print informative statements throughout execution

4. CROSS-VALIDATION 

5. FIX +/- mode declarations (!!!)

6. Implement a file-based (runs simply XHAIL) and a db-based (runs ILED) version.
   Have some examples for the file based and an easy to install test for the 
   database version.  


"""
"""
Fix mongo connectivity issues:
Manually remove the lockfile: sudo rm /var/lib/mongodb/mongod.lock
Run the repair script: sudo -u mongodb mongod -f /etc/mongodb.conf --repair
tart your MongoDB server with sudo start mongodb and verify it is running with sudo 
status mongodb and by trying to connect to it with mongo test.
"""


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
        
    #for i in (110,120):    
        #i = 250
        #print(i)
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
    print('\n')                  
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
            gl.runargs.update({"coverage":"heuristic"})
            gl.runargs.update({"mode":"batch"})
            batchMode() # always use heuristic in batch mode (see the method)
    else:    
        learn()
        #print('What you want to do?')    
    #if 'set_cover_search' in args and args['set_cover_search']:
    #    learn(set_cover_search=True)
    #else:
    #    learn(set_cover_search=False)          









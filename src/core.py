'''
Created on Jul 2, 2014

@author: nkatz
'''
from pymongo import Connection
import os
import logging
import sys
import argparse

import re
from compiler.ast import flatten


# Input to the main learning function:
# DB name
# granularity?
# example pattern


class core():
    
    runargs = {"mode":"incremental","cover-search":False,"coverage":"perfect-fit",
               "clause_level_search":False,"incremental_solve":False,"debug":False}
    
    example_patterns = []

    example_constraints_cover = []
    
    heuristic_example_constraints_cover = []
    
    example_constraints_reject = []
    
    heuristic_example_constraints_reject = []
    
    current_delta = None
    
    current_kernel = None
    
    default_step = 10
    
    current_var_kernel = []
    
    current_hypothesis = {} # the running hypothesis at each point split in 'new', 'retained', 'specialized'
    
    current_example = 0
    
    current_example_object = None
    
    use_dict = {}
    
    logger = None
    
    #db_name,db_collection = 'examples-3-8-2013_granularity_50','examples'
    #db_name,db_collection = 'caviar-synthetic_granularity_100','examples'
    db_name,db_collection = 'caviar-10','examples'
    #db_name,db_collection = 'CTM-granularity-10','examples'
    
    db,collection,globals = None,None,None
    
    modeh,modeb = None,None
    
    seen_examples = []
    
    cwd = os.getcwd()
    
    subsumes = os.path.join(os.path.dirname(cwd),'pl','sub.pl')
    
    bk = os.path.join(os.path.dirname(cwd),'knowledge','bk.lp')
    
    examples = os.path.join(os.path.dirname(cwd),'knowledge','examples.lp') 
    
    modes = os.path.join(os.path.dirname(cwd),'knowledge','modes.pl') 
    
    modeHsvarbed = []
    
    modeBsvarbed = []
    
    clingo = os.path.join(os.path.dirname(cwd),'lib','./clingo') 
    
    abdinp = os.path.join(os.path.dirname(cwd),'runtime','abdin.lp')
    
    dedinp = os.path.join(os.path.dirname(cwd),'runtime','dedin.lp')
    
    indinp = os.path.join(os.path.dirname(cwd),'runtime','indin.lp')
    
    helper = os.path.join(os.path.dirname(cwd),'runtime','helper.lp')
    
    ground = os.path.join(os.path.dirname(cwd),'runtime','ground.lp')
    
    #test_theory = os.path.join(os.path.dirname(cwd),'runtime','test-theory.lp') 
    
    caviar_constr = os.path.join(os.path.dirname(cwd),'knowledge','caviar-constr.lp')
    
    example_coverage_constr = os.path.join(os.path.dirname(cwd),'knowledge','exmpl-cov-constr.lp')
    
    example_reject_constr = os.path.join(os.path.dirname(cwd),'knowledge','exmpl-reject-constr.lp')
    
    kernel_path = os.path.join(os.path.dirname(cwd),'runtime','kernel-set.lp')
    
    var_kernel_path = os.path.join(os.path.dirname(cwd),'runtime','var-kernel-set.lp')
    
    prior_theory_path = os.path.join(os.path.dirname(cwd),'runtime','prior-theory.lp')
    
    final_result_file = os.path.join(os.path.dirname(cwd),'theory')
    
    crossval_path = os.path.join(os.path.dirname(cwd),'runtime','crossval.lp')
    
    prior_theory_debug = os.path.join(os.path.dirname(cwd),'dev-debug','debug-prior-theory.lp')
    
    py_prior_theory_debug = os.path.join(os.path.dirname(cwd),'dev-debug')
    
    vardepth = 4
    
    def __init__(self,**kwargs):
        log = os.path.join(os.path.dirname(self.cwd),'logger')
        os.remove(log) if os.path.exists(log) else None
        #os.remove(os.path.join(os.path.dirname(self.cwd),'logger'))
        self.init_mongo()
        self.parse_modes()
        self.init_logger()
        (cov,reject) = self.generate_exmplcov_constraints()
        (covh,rejecth) = self.generate_heuristic_exmplcov_constraints()
        self.example_constraints_cover = cov
        self.heuristic_example_constraints_cover = covh
        self.example_constraints_reject = reject
        self.heuristic_example_constraints_reject = rejecth
        core.globals = self
     
    def generate_exmplcov_constraints(self):
        coverschema,rejectschema = [],[]
        for x in self.example_patterns:
            # :- example(holdsAt(fluent(A,B,C),D)), not holdsAt(fluent(A,B,C),D).
            # :- holdsAt(fluent(A,B,C),D), not example(holdsAt(fluent(A,B,C),D)).
            x1 = ':- example(%s), not %s.'%(x,x)
            x2 = ':- %s, not example(%s).'%(x,x)
            coverschema.extend([x1,x2])
            rejectschema.append(x2)
        return (coverschema,rejectschema)      
    
    def generate_heuristic_exmplcov_constraints(self):
        coverschema,rejectschema = [],[]
        negs_minimize = ','.join(['%s:not example(%s)'%(x,x) for x in self.example_patterns])
        negs_covered_clause = 'negsCovered(N) :- N = #count{%s}.'%(negs_minimize)
        negs_minimize_statement = '#minimize{%s}.'%(negs_minimize)
        pos_minimize = ','.join(['not %s:example(%s)'%(y,y) for y in self.example_patterns])
        pos_covered_clause = \
        'posCovered(N) :- N = #count{%s}.'%(','.join(['%s:example(%s)'%(z,z) for z in self.example_patterns]))
        minimize_statement = '#minimize{%s,%s}.'%(pos_minimize,negs_minimize)    
        coverschema.extend([minimize_statement,
                            pos_covered_clause,
                            negs_covered_clause,
                            '#show posCovered(N).',
                            '#show negsCovered(N).'])
        rejectschema.extend([negs_minimize_statement,negs_covered_clause,'#show negsCovered(N).'])
        return (coverschema,rejectschema)
        
    def init_mongo(self):
        """ get a connection to the examples mongo db """
        connection = Connection()
        db = connection[self.db_name]
        col = db[self.db_collection]
        self.db = db
        self.collection = col
        #self.globals = self
        
    def parse_modes(self):
        """ get mode declarations """
        f = open(self.modes,'r')
        g1 = lambda x: x.replace(" ","").split('modeh(')[1][:-1]
        g2 = lambda x: x.replace(" ","").split('modeb(')[1][:-1]
        g3 = lambda x: x.replace(" ","").split('examplePattern(')[1][:-1] 
        m = [x.replace('.','').strip() for x in f.read().splitlines() \
                       if not x.startswith(':-') and not x.startswith('%') and 'modeh' in x]
        self.modeh = map(g1,m)
        f = open(self.modes,'r')
        m = [x.replace('.','').strip() for x in f.read().splitlines() \
                      if not x.startswith(':-') and not x.startswith('%') and 'modeb' in x]
        self.modeb = map(g2,m)
        f = open(self.modes,'r')
        m = [x.replace('.','').strip() for x in f.read().splitlines() \
                      if not x.startswith(':-') and not x.startswith('%') and 'examplePattern' in x]
        m = [self.variabilize_mode(x) for x in m]
        self.example_patterns = map(g3,m)
        # Variabilize modes too and keep them in the core
        self.modeHsvarbed = [self.variabilize_mode(x) for x in self.modeh]
        self.modeBsvarbed = [self.variabilize_mode(x) for x in self.modeb]
        
          
     
    def variabilize_mode(self,mode):
        """Returns the variabilized mode only."""
        words = '[A-Za-z0-9_]+'
        
        plmrks = lambda x,y: re.findall('\\'+str(y)+words,x)
        inp = plmrks(mode,'+')
        out = plmrks(mode,'-')
        gr = plmrks(mode,'#')
        all = flatten([inp,out,gr])
        d,v = {},0   
        for mo in all:
            if mo in d:
                #n = d[mo]
                mode = self.replace_nth(mode,mo,'X'+str(v),1) 
                v += 1
                d[mo] += 1
            else:
                mode = self.replace_nth(mode,mo,'X'+str(v),1) 
                v += 1
                d[mo] = 1 
        return mode      
    
    def find_nth(self,source, target, n):
        num = 0
        start = -1
        while num < n:
            start = source.find(target, start+1)
            if start == -1: return -1
            num += 1
        return start

    def replace_nth(self,source, old, new, n):
        p = self.find_nth(source, old, n)
        if n == -1: return source
        return source[:p] + new + source[p+len(old):]            
        
    def init_logger(self):
        """ initialize logger """  
        logger = logging.getLogger('py-iled')
        hdlr = logging.FileHandler(os.path.join(os.path.dirname(self.cwd),'logger'))
        formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
        hdlr.setFormatter(formatter)
        logger.addHandler(hdlr) 
        logger.setLevel(logging.INFO)
        self.logger = logger
           
    def active(self):
        return self    

#--------------------
global_vals = core()   
#--------------------    

def parseargs():
    parser = argparse.ArgumentParser(description='Incremental Learning of'+ 
    ' Event Definitions')
    parser.add_argument('--with-apppath', metavar='PATH',
                        help='PATH is a path to a folder wher 3 files must exist: \'bk.lp\', containing background knowledge, \'examples.lp\' containing the examples to learn from and \'modes.lp\' containing a set of mode declarations')
    parser.add_argument('--with-db', metavar='DBNAME',
                        help='Use the specified database for incremental learning. Throws an error if the database does not exist')
    
    parser.add_argument('--inclearn',metavar='',
                        help='Perform incremental learning. Must provide an existing database of examples.')
    parser.add_argument('--with-gn', metavar='GRAN',
                        help='Merges data fetched from the database into windows of specified granularity')
    
    parser.add_argument('--batchlearn',metavar='',
                        help='Perform batch learning. Must provide a path /path/to/my/app 3 files must exist: \'bk.lp\', containing background knowledge, \'examples.lp\' containing the examples to learn from and ')
    
    #parser.add_argument('--sum', dest='accumulate', action='store_const',
    #               const=sum, default=max,
    #               help='sum the integers (default: find the max)')

    args = parser.parse_args(sys.argv)
    print(args)
    #print(args.accumulate(args))  
 

 
 
def setdb(dbname):
    global_vals.db_name = dbname     
    
    
def generate_db(**kwargs):
    import functs,utils
    global global_vals
    #t = lambda _list: reduce(lambda x,y: str(x)+'@'+str(y),_list) if _list != [] else ''
    t = lambda _list: '@'.join(_list) if _list != [] else ''
    db,col,gran = None,None,None
    if 'db' in kwargs:
        db = kwargs['db']
        col = 'examples'
    else:
        db = global_vals.db_name
        col_name = global_vals.db_collection
    if 'gran' not in kwargs:
        print('Please provide time granularity for the database to be generated')
        sys.exit()
    else:
        gran = kwargs['gran']
        print('Generating a new db from mother db %s with time granularity = %s')%(db,gran)
    connection = Connection()
    dbs = connection.database_names()
    if db not in dbs:
        print('ERROR: No such mother database exists: %s')%(db)
        sys.exit()
    else:  
        db_ = connection[db]
        size = db_.examples.count() 
        print('DB contains %s examples'%(str(size)))
        db = db+'_granularity_'+str(gran)
        print('Generating new db: %s')%(db)  
        connection.drop_database(db) ## clear if exists
        db = connection[db]
        step = int(gran)
        for i in range(0,size,step):
            exists = True
            anot_i,nar_i,innert_i = [],[],[]
            j,k = i-step,i+1
            cursor = db_.examples.find({'example':{"$gt": j,"$lt": k }})
            (pos,nar) = utils.get_from_cursor(cursor)
            if j >= 0:
                nar.append('starttime(%s)'%(str(j)))
            if True:
                try:
                    post = {'example':i,'pos':pos,'nar':nar}
                    print('#Example,IntrvStart,IntrvEnd:',i,i-step,i)
                except TypeError:
                    print('TypeError at')
                    print(anot_i)
                    print(nar_i)
                    print(innert_i)
                    sys.exit()    
                db.examples.insert(post)     
   
    
    
   


'''
Created on Jul 4, 2014

@author: nkatz
'''

import sys
import functs
from compiler.ast import flatten
import asp
import excps
import subsumption


class Clause():
    
    def __init__(self,litlist,globvals,*var_lit_args):
        self.as_list = None
        self.head = None
        self.body = None
        self.as_str_list = None
        self.as_string = None
        self.as_string_with_var_types = None
        self.support = []
        self.ident = '        '
        self.printout = ',\n'+self.ident
        self.globvals = globvals
        if var_lit_args == ():
            if not self.are_literals(litlist):
                lit_list = [Literal(x,globvals) for x in litlist]
            else:
                lit_list = litlist    
        else:
            lit_list = [Literal(None,None,**x) for x in var_lit_args[0]]
        self.as_str_list = [x.as_string for x in lit_list]
        self.head = lit_list[0]
        lit_list.pop(0)
        self.body = lit_list
        bstr = '       '+self.printout.join([x.as_string for x in self.body]) if self.body != [] else ''
        self.as_string = '%s :- \n %s.'%(self.head.as_string,bstr) if self.body != [] else '%s.'%(self.head.as_string)
        self.as_string_with_var_types = self.get_var_types_() 
        #['fluentName(fighting)', 'eventName(active)', 'person(id2)', 'person(id1)', 'ttime(10)']
            
                    
    def are_literals(self,litlist):
        #return reduce(lambda x,y: isinstance(x,Literal) and isinstance(y,Literal),litlist)
        return all(isinstance(x,Literal) for x in litlist)   
    
    def get_support_clause(self,i):
        return self.support[i]
    
    def get_var_types_(self):
        lit = [self.head]
        lit.extend(self.body)
        var_types = []
        if isinstance(lit,Literal): 
            var_types = ['%s(%s)'%(functs.de_sign(lit.terms_types_map[key]),key) for key in lit.terms_types_map ]
        elif isinstance(lit,list):
            _var_types = flatten([['%s(%s)'%(functs.de_sign(_lit.terms_types_map[key]),key) for key in _lit.terms_types_map ] for _lit in lit])
            var_types = set(_var_types)
        else:
            msg = 'You can ask for the types of variables of a Literal or a list of Literals. You asked for %s'%(lit)
            raise excps.VariableTypesException(msg,self.globvals.logger)         
        # return list(var_types)
        l = list(var_types)
        b = [x.as_string for x in self.body]
        b.extend(l)
        bstr = '       '+self.printout.join(b)
        t = '%s :- \n %s.'%(self.head.as_string,bstr)
        return t
    
 
        
      
        

class Literal():
    
    def __init__(self,lit,globvals,**var_lit_args):
        if lit == 'holdsAt(abrupt_acceleration(75,bus,abrupt),22)':
            stop = 'stop'
        self.subsuming_mode = None
        self.terms_types_map = {}
        self.globvals = None
        self.as_string = None
        #if var_lit_args == {}:
        if any(not x in var_lit_args for x in ['literal','subsuming_mode','var_types_map']):
            self.globvals = globvals
            self.as_string = lit
            if isinstance(lit,basestring):
                self.subsuming_mode = self.get_subsuming_decl(lit)    
                self.terms_types_map = self.get_terms_types_map(lit)
            elif isinstance(lit,Literal):
                self.subsuming_mode = lit.subsuming_mode
                self.terms_types_map = lit.terms_types_map   
        else:
            self.as_string = var_lit_args['literal']
            self.subsuming_mode = var_lit_args['subsuming_mode']
            self.terms_types_map = var_lit_args['var_types_map'] 
    
    def get_terms_types_map(self,lit):
        _map = {}
        mode = self.subsuming_mode 
        for s in ['+','-','#']:
            terms = functs.plm_pattern(mode,s)
            d = self.get_maps(lit,terms,s)
            _map.update(d)
        return _map    

    def get_subsuming_decl_(self,lit):
        modebs,modehs = self.globvals.modeb,self.globvals.modeh
        modes = flatten([modebs,modehs]) 
        x = {m:self.variabilize_mode_(m) for m in modes}
        sumsuming = None
        for m in x:
            if 'passenger_satisfaction' in m:
                stop = 'stop'
            (map_,varmode) = x[m]
            (subsumes,substitution) = subsumption.theta_subsumes([varmode], [lit], modes_subsumption=True)
            if subsumes:
                print('ok!')
                print(map_)
                sumsuming = m
    
    def get_subsuming_decl(self,lit):
        if lit == 'holdsAt(orntdiff(id2,id1,45),69879)':
            stop = 'here'
        modebs,modehs = self.globvals.modeb,self.globvals.modeh
        modes = flatten([modebs,modehs]) 
        mcopy = {self.variabilize_mode(m):m for m in modes}
        sumsuming = None
        for m in mcopy:
            if asp.theta_subsumes([m],[lit]):
                sumsuming = m
                break
        if sumsuming == None:
            msg = 'No matching mode declaration schema found for atom %s'%(lit)
            raise excps.ModeDeclarationsMatchingException(msg)
        return mcopy[sumsuming]
    
    def variabilize_mode(self,mode):
        """Returns the variabilized mode only."""
        if 'abrupt_acceleration(' in mode:
            stop = 'stop'
        inp = functs.plmrks(mode,'+')
        out = functs.plmrks(mode,'-')
        gr = functs.plmrks(mode,'#')
        all = flatten([inp,out,gr])
        d,v = {},0   
        for mo in all:
            if mo in d:
                n = d[mo]
                mode = functs.replace_nth(mode,mo,'X'+str(v),1) 
                v += 1
                d[mo] += 1
            else:
                mode = functs.replace_nth(mode,mo,'X'+str(v),1) 
                v += 1
                d[mo] = 1 
        return mode 
    
    def variabilize_mode_(self,mode):
        """Returns the variabilized mode in addition to a variables/placemarkers map.
           This is used to find if a mode declaration subsumes an atom (using the
           theta_subsumption function from subsumption)"""
        if 'abrupt_acceleration(' in mode:
            stop = 'stop'
        inp = functs.plmrks(mode,'+')
        out = functs.plmrks(mode,'-')
        gr = functs.plmrks(mode,'#')
        all_ = flatten([inp,out,gr])
        d,v,map_ = {},0,{}   
        for mo in all_:
            mode = functs.replace_nth(mode,mo,'X'+str(v),1) 
            map_.update({'X'+str(v):mo})
            v += 1
            if mo in d:
                #n = d[mo]
                d[mo] += 1
            else:
                d[mo] = 1 
        return (map_,mode) 
    
    def get_maps(self,atom,search_patterns,sign):
        #out = []
        with open(self.globvals.ground,'w') as f:
            f.write('%s.\n\n'%(atom))
            f.write(''.join(map(lambda (x,y): '{term(X,%s):%s}.\n'%(y,x),search_patterns)))
            f.write('#hide.\n')
            f.write('#show term/2.\n')
        f.close()   
        out = asp.ground()     
        k = [functs.determ(x) for x in out]    
        return {x[0]:sign+x[1] for x in k}
    
    

    
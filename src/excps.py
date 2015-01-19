'''
Created on Jul 5, 2014

@author: nkatz
'''


class TypeException(Exception):
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)            
        """
        if errors is not None: 
            super().__init__(self, msg, errors) # Call the base class constructor
        else: 
            super().__init__(self, msg)
        """ 
          
class AnalyzeUseTryException(Exception):  
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)  
        
class DeltaSetException(Exception):  
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)   
        
class Use_2_HeadNotAbducedException(Exception):
                      
    def __init__(self, msg, logger, **errors):
        logger.error(msg)         
     
class VariableTypesException(Exception):
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)
       
        
class ParsingException(Exception):
                      
    def __init__(self, msg, **errors):
        print(msg)           
        
class InductionException(Exception):   
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)     
        
class ExmplProcessingDirection(Exception):
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg) 
        
class KernelSetNotFoundException(Exception):
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)         
            
class HypothesisTestingException(Exception):
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)     
        
class ModeDeclarationsMatchingException(Exception):
    
    def __init__(self, msg, **errors):
        print(msg)         
        
class SupportSetException(Exception):
    
    def __init__(self, msg, logger, **errors):
        logger.error(msg)          
                
            
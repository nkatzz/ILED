'''
Created on Jul 9, 2014

@author: nkatz
'''

import random,os,sys,subprocess
from pymongo import Connection

behavs = ['walking','active','inactive','running','abrupt','abrupt1','abrupt2','walking1','walking2']
#behavs = ['abrupt']
orient = [0,45,60,90,120,180,200,270,360,300]
vis = ['visible','invisible']
coords = [x for x in range(80,100)]
persons = ['id1','id2']
evpat = 'happensAt(event(%s,%s),%s)'   # event, person, time
flpat = 'holdsAt(fluent(%s,%s,%s),%s)' # fluent, person, person, time
orientpat = 'orientation(%s,%s,%s)'    # person, orient., time
vispat = 'holdsAt(%s,%s,%s)'           # visible, person, time
coordspat = 'coords(%s,%s,%s,%s)'      # person, x, y, time 
personspat = 'person(%s)'
timepat = 'ttime(%s)'
time = (x for x in range(0,100000))

f = lambda x: random.choice(x)
g = lambda x,y: x[y]


cwd = os.getcwd()
clingo = os.path.join(os.path.dirname(cwd),'lib','./clingo')
aspf = os.path.join(cwd,'aspinput.lp')
bk = os.path.join(cwd,'bk.lp')
options = [clingo,bk,aspf,'0', '--asp09']
command = ' '.join(options)

connection = Connection()
db = connection['caviar-synthetic']
col = db['examples']
connection.drop_database(db) ## clear if exists
 


def write_to_file(_file,msg):
    with open(_file,'w') as f:
        f.write(msg)
    f.close()
    
def cmd():
    result = []
    try:
        p = subprocess.check_output(options, stderr=subprocess.STDOUT)
        result = p
    except Exception, e:
        result = str(e.output)
        result = result.splitlines()
        result = [x for x in result if not x.strip()=='' and not 'warning' in x]     
        if result != []:
            result = result[0].split('.')
            result = [x.strip() for x in result if not x.strip()=='']
        
            print(result)
    return result        
    
 
    
for t in time:
    #print(t)
    d = {x:{'event':f(behavs),'or':f(orient),'vis':f(vis),'x':f(coords),'y':f(coords)} for x in persons}
    narrative = [[evpat%(g(d,x)['event'],x,str(t)),
                  orientpat%(x,g(d,x)['or'],str(t)),
                  vispat%(g(d,x)['vis'],x,str(t)),
                  coordspat%(x,g(d,x)['x'],g(d,x)['y'],str(t))] for x in d]
    narrative = [x for y in narrative for x in y]
    db_narrative = [x for x in narrative] # copy it to avoid the person/1, ttime/1 info to be stored to the db
    narrative.extend([timepat%(str(t)),timepat%(str(t+1))])
    narrative.extend([personspat%(x) for x in persons])
    write_to_file(aspf,'.\n'.join(narrative)+'.')
    annotation = cmd()
    #annotation = '@'.join(annotation)
    #db_narrative = '@'.join(db_narrative)
    post = {'example':t,'pos':annotation,'nar':db_narrative}
    db.examples.insert(post)
    
        

    #os.popen(command).read().split('.')
    
    #print(p)
    


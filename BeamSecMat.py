from openseespy.opensees import *


################## nominal concrete compressive strength ##############
fc =   -52.e6
Ec =  33892180000
nu = 0.2
Gc =  33892180000/(2.*(1+0.2))
#BEAM IN ALL STORIES  B40x60
fc1C = -54.5896e6
eps1C = -0.002801329
fc2C = -14.5896e6
eps2C =  -0.014006643

epsc0 = 0.002801329
#tensile - Strength properties
ftC = 4.617798447e6
ftU = 0.000224286
Ets = 0.000224286/0.002801329
MatIDconcCoreB1 = 20000
uniaxialMaterial ( 'Concrete02' , 20000 , -54.5896e6 , -0.002801329 , -14.5896e6 , -0.014006643 , 0.1 , 4.617798447e6 , 0.08006414098451128)
#BEAM IN STORIES 1-20 B55x70
fc1C = -59.59e6
eps1C = -0.003879712
fc2C = -19.59e6
eps2C =  -0.019398558

#tensile - Strength properties
ftC = 4.824659962e6
ftU = 0.000224286
Ets = 0.000224286/0.003879712
MatIDconcCoreB2 = 30000
uniaxialMaterial ( 'Concrete02' , 30000 , -59.59e6 , -0.003879712 , -19.59e6 , -0.019398558 , 0.1 , 4.824659962e6 , 0.057809961151755594)
#BEAM IN STORIES 21-30 B55x70
fc1C = -58.07e6
eps1C = -0.003551909
fc2C = -18.07e6
eps2C = -0.017759547

epsc0 = 0.003551909
#tensile - Strength properties
ftC = 4.762729653e6
ftU = 0.000224286
Ets = 0.000224286/0.003551909
MatIDconcCoreB3 = 40000
uniaxialMaterial ( 'Concrete02' , 40000 , -58.07e6 , -0.003551909 , -18.07e6 , -0.017759547 , 0.1 , 4.762729653e6 , 0.06314519882125359)
#UNCONFINED CONCRETE
fc1C = -52.e6
eps1C = -0.002242857
fc2C = -12.e6
eps2C = -0.0036

epsc0 = 0.002242857
ftC = 4.506939094e6
ftU = 0.000224286
Ets = 0.000224286/0.002242857
MatIDconcCoreB4 = 50000
uniaxialMaterial ( 'Concrete02' , 50000 , -52.e6 , -0.002242857 , -12.e6 , -0.0036 , 0.1 , 4.506939094e6 , 0.1000001337579703)
Fy = 491.5e6
Es = 200.0e9
Bs = 0.02
Bs = 0.02
cR1 = 0.925
cR2 = 0.15
MatIDSteel = 60000
uniaxialMaterial ( 'Steel02' , 60000 , 491.5e6 , 200.0e9 , 0.02 , 20 , 0.925 , 0.15)





from openseespy.opensees import *


################## nominal concrete compressive strength ##############
fc =   -58.5e6
Ec =  38242646352
nu = 0.2
Gc =  38242646352/(2.*(1+0.2))


#BEAM IN ALL STORIES  B40x60
fc1C = -61.14e6
eps1C = -0.002862747
fc2C = -14.64e6
eps2C =  -0.014313736

epsc0 = 0.002862747
#tensile - Strength properties
ftC = 4.887004451e6
ftU = 1.629001484e6
Ets = ftU/epsc0
MatIDconcCoreB1 = 20000
uniaxialMaterial ( 'Concrete02' , 20000 , fc1C , eps1C , fc2C , eps2C , 0.1 , ftC , Ets)


#BEAM IN ALL STORIES  B55x70
fc1C = -67.54e6
eps1C = -0.004140403
fc2C = -21.04e6
eps2C =  -0.020702015

epsc0 = 0.004140403

#tensile - Strength properties
ftC = 5.136420203e6
ftU = 1.712140068e6
Ets = ftU/epsc0
MatIDconcCoreB2 = 30000
uniaxialMaterial ( 'Concrete02' , 30000 , fc1C , eps1C , fc2C , eps2C , 0.1 , ftC , Ets)


#UNconfined concrete
fc1C = fc
eps1C = -0.002335714
fc2C = -12.e6
eps2C =  -0.0036

epsc0 = 0.002335714

#tensile - Strength properties
ftC = 4.780330794e6
ftU = 1.593443598e6
Ets = ftU/epsc0
MatIDconcCoreB2 = 50000
uniaxialMaterial ( 'Concrete02' , 50000 , fc1C , eps1C , fc2C , eps2C , 0.1 , ftC , Ets)


#Steel stress strain model for beams
Fy = 491.5e6
Es = 200.0e9
Bs = 0.02
Bs = 0.02
cR1 = 0.925
cR2 = 0.15
MatIDSteel = 60000
uniaxialMaterial ( 'Steel02' , 60000 , 491.5e6 , 200.0e9 , 0.02 , 20 , 0.925 , 0.15)





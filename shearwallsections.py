from opensees.openseespy import *
################## nominal concrete compressive strength ##############
fc =   -65.e6
Ec =  37892611417
#UNCONFINED CONCRETE
fc1C = -65.e6
eps1C = -0.003846016
fc2C = -19.5875e6
eps2C = -0.019230082
epsc0 = 0.003846016
ftC = 5.038911093e6
ftU = 1.679637031e6
Ets = 1.679637031e6/0.003846016
UCconcrete = 1
model.uniaxialMaterial( 'Concrete02' , 1 , -65.e6 , -0.003846016 , -19.5875e6 , -0.019230082 , 0.1 , 5.038911093e6 , 436721280.1506806)
Fy = 491.5e6
Es = 200.0e9
Bs = 0.02
Bs = 0.02
cR1 = 0.925
cR2 = 0.15
RebarMatTag = 400
model.uniaxialMaterial( 'Steel02' , 400 , 491.5e6 , 200.0e9 , 0.02 , 20 , 0.925 , 0.15)
#P19,P22,P23,P26,P20,P21,P24,P25
fc1C = -88.17e6
eps1C = -0.006757033
fc2C = -35.17e6
eps2C =  -0.010406166
epsc0 = 0.006757033
#tensile - Strength properties
ftC = 5.868680111e6
ftU = 1.956226704e6
Ets = 1.956226704e6/0.006757033
CCp19p22p23p26 = 2
model.uniaxialMaterial( 'Concrete02' , 2 , -88.17e6 , -0.006757033 , -35.17e6 , -0.010406166 , 0.1 , 5.868680111e6 , 289509715.8767761)
#P1,P2,P3,P4---1
fc1C = -88.72e6
eps1C = -0.006826154
fc2C = -35.54e6
eps2C =  -0.010470608
epsc0 = 0.006826154
#tensile - Strength properties
ftC = 5.88695592e6
ftU = 1.96231864e6
Ets = 1.96231864e6/0.006826154
CCp1p2p3p41 = 3
model.uniaxialMaterial( 'Concrete02' , 3 , -88.72e6 , -0.006826154 , -35.54e6 , -0.010470608 , 0.1 , 5.88695592e6 , 287470607.90014404)
#P1,P2,P3,P4,P5,P9,P10,P14,P37,P38,P39,P40---2
fc1C = -88.01e6
eps1C = -0.006727143
fc2C = -35.01e6
eps2C =  -0.01037764
epsc0 = 0.006727143
#tensile - Strength properties
ftC = 5.863352816e6
ftU = 1.954450939e6
Ets = 1.954450939e6/0.006727143
CCp1p2p3p42 = 4
model.uniaxialMaterial( 'Concrete02' , 4 , -88.01e6 , -0.006727143 , -35.01e6 , -0.01037764 , 0.1 , 5.863352816e6 , 290532093.4905056)
#P5,P9,P10,P14,P6,P8,P11,P13,P31,P35---1
fc1C = -88.79e6
eps1C = -0.006872857
fc2C = -35.79e6
eps2C =  -0.010516717
epsc0 = 0.006872857
#tensile - Strength properties
ftC = 5.889277863e6
ftU = 1.963092621e6
Ets = 1.963092621e6/0.006872857
CCp5p9p10p141 = 5
model.uniaxialMaterial( 'Concrete02' , 5 , -88.79e6 , -0.006872857 , -35.79e6 , -0.010516717 , 0.1 , 5.889277863e6 , 285629778.2712488)
#P6,P8,P11,P13,P7,P12---2
fc1C = -87.66e6
eps1C = -0.006661758
fc2C = -34.66e6
eps2C =  -0.010315243
epsc0 = 0.006661758
#tensile - Strength properties
ftC = 5.85168245e6
ftU = 1.950560817e6
Ets = 1.950560817e6/0.006661758
CCp6p8p11p132 = 6
model.uniaxialMaterial( 'Concrete02' , 6 , -87.66e6 , -0.006661758 , -34.66e6 , -0.010315243 , 0.1 , 5.85168245e6 , 292799710.9771925)
#P7,P12---1
fc1C = -88.11e6
eps1C = -0.006745824
fc2C = -35.11e6
eps2C =  -0.010395468
epsc0 = 0.006745824
#tensile - Strength properties
ftC = 5.866682943e6
ftU = 1.955560981e6
Ets = 1.955560981e6/0.006745824
CCp7p12 = 7
model.uniaxialMaterial( 'Concrete02' , 7 , -88.11e6 , -0.006745824 , -35.11e6 , -0.010395468 , 0.1 , 5.866682943e6 , 289892084.4955338)
#P37,P38,P39,P40---1
fc1C = -88.54e6
eps1C = -0.006826154
fc2C = -35.54e6
eps2C =  -0.010472138
epsc0 = 0.006826154
#tensile - Strength properties
ftC = 5.866682943e6
ftU = 1.960326999e6
Ets = 1.960326999e6/0.006826154
CCp37p38p39p40 = 8
model.uniaxialMaterial( 'Concrete02' , 8 , -88.54e6 , -0.006826154 , -35.54e6 , -0.010472138 , 0.1 , 5.880980998e6 , 287178841.70207703)
#P27,P28,P29,P30
fc1C = -88.61e6
eps1C = -0.006839231
fc2C = -35.5435e6
eps2C =  -0.01048462
epsc0 = 0.006839231
#tensile - Strength properties
ftC = 5.8833053e6
ftU = 1.961101767e6
Ets = 1.961101767e6/0.006839231
CCp27p28p29p30 = 9
model.uniaxialMaterial( 'Concrete02' , 9 , -88.61e6 , -0.006839231 , -35.5435e6 , -0.01048462 , 0.1 , 5.8833053e6 , 286743022.2783819)
model.uniaxialMaterial( 'Elastic' , 300 , 1339774475)
model.uniaxialMaterial( 'Elastic' , 301 , 1461572155)
model.uniaxialMaterial( 'Elastic' , 302 , 1116478729)
model.uniaxialMaterial( 'Elastic' , 303 , 1004830856)
model.uniaxialMaterial( 'Elastic' , 304 , 669887237.6)
model.uniaxialMaterial( 'Elastic' , 305 , 1589935051)
model.uniaxialMaterial( 'Elastic' , 306 , 1565257480)
model.uniaxialMaterial( 'Elastic' , 307 , 1449378113)
model.uniaxialMaterial( 'Elastic' , 308 , 1304895709)
model.uniaxialMaterial( 'Elastic' , 309 , 1226082368)
model.uniaxialMaterial( 'Elastic' , 310 , 1188513494)
model.uniaxialMaterial( 'Elastic' , 311 , 1263207202)
model.uniaxialMaterial( 'Elastic' , 312 , 1188513494)
model.uniaxialMaterial( 'Elastic' , 313 , 1172751625)
model.uniaxialMaterial( 'Elastic' , 314 , 1114434495)
model.uniaxialMaterial( 'Elastic' , 315 , 782143416)
model.uniaxialMaterial( 'Elastic' , 316 , 1565874851)

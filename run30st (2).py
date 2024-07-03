import math as math
from math import *
import openseespy.opensees as ops

from openseespy.opensees import *

# from RC3D1Story import RC3D1Story
# from mat import mat
# from RC3D1Story import *
from BuildRCrectSection import *
import opsvis as opsvis

import opsvis as opsvis
import matplotlib.pyplot as plt
import math as math
import winsound
import os
import os.path
import shutil
import pathlib
import time
from concurrent.futures import ProcessPoolExecutor
from concurrent.futures import ThreadPoolExecutor
import multiprocessing as mp
import vfo.vfo as vfo

# from joblib import Parallel, delayed

wipe()

# from openseespy.opensees import *
def myParallelModel(mm):
 model('basic', '-ndm', 3, '-ndf', 6)

# from RC3D1Story import *
# from mat import *

# from BuildRCrectSection import BuildRCrectSection

# exec(open("mat.py").read())

# ops.mkdir('data3d')

# ops.source('mat.py')
# ops.source('RC3D1Story.py')
 exec(open("BeamSecMat.py").read())
# from BuildRCrectSection import BuildRCrectSection
# beam sections
 BuildRCrectSection(1000, 0.40, 0.60, 0.04, 20000, 50000, 60000, 10, 0.020, 6, 4, 8, 5, 5,5)
 BuildRCrectSection(2000, 0.40, 0.60, 0.04, 20000, 50000, 60000, 12, 0.020, 7, 5, 8, 5, 5, 5)
 BuildRCrectSection(3000, 0.55, 0.70, 0.04, 30000, 50000, 60000, 22, 0.022, 11, 11, 8, 5, 5, 5)
 BuildRCrectSection(4000, 0.55, 0.70, 0.04, 40000, 50000, 60000, 24, 0.022, 12, 12, 8, 5, 5, 5)
# #girder sections
 BuildRCrectSection(101, 0.40, 0.60, 0.04, 20000, 50000, 60000, 19, 0.020, 10, 9, 8, 5, 5, 5)
 BuildRCrectSection(102, 0.40, 0.60, 0.04, 20000, 50000, 60000, 20, 0.020, 10, 10, 8, 5, 5, 5)
 BuildRCrectSection(103, 0.55, 0.70, 0.04, 30000, 50000, 60000, 30, 0.022, 15, 15, 8, 5, 5, 5)
 BuildRCrectSection(104, 0.55, 0.70, 0.04, 40000, 50000, 60000, 24, 0.022, 12, 12, 8, 5, 5, 5)

# Procedure to build RC rectangular section
# def BuildRCrectSection(SecTag, BSec, HSec, cover, coreID, coverID, steelID, totalnumBars, barDiameter, numBarsTop, numBarsBot, nfCoreY, nfCoreZ, nfCoverY, nfCoverZ):
#     coverY = HSec / 2.0
#     coverZ = BSec / 2.0
#     coreY = coverY - cover
#     coreZ = coverZ - cover
#     numBarsInt = totalnumBars - (numBarsTop + numBarsBot) / 2
#     barArea = 3.14 * pow(barDiameter, 2) / 4.0
#     DisBarL = (HSec - 2 * cover) / (numBarsInt + 1)
#
# GJ = 1.e10
# section('Fiber', SecTag ,'-GJ',GJ)
#     # Define fiber section
# patch('rect', coreID, nfCoreZ, nfCoreY, -coreY, coreZ, -coreY, -coreZ, coreY, -coreZ, coreY, coreZ)
# patch('rect', coverID, 2, nfCoverY, -coverY, coverZ, -coreY, coreZ, coreY, coreZ, coverY, coverZ)
# patch('rect', coverID, 2, nfCoverY, -coreY, -coreZ, -coverY, -coverZ, coverY, -coverZ, coreY, -coreZ)
# patch('rect', coverID, nfCoverZ, 2, -coverY, coverZ, -coverY, -coverZ, -coreY, -coreZ, -coreY, coreZ)
# patch('rect', coverID, nfCoverZ, 2, coreY, coreZ, coreY, -coreZ, coverY, -coverZ, coverY, coverZ)

# layer('straight', steelID, numBarsInt, barArea, -coreY + DisBarL, coreZ, coreY - DisBarL + 0.01, coreZ)
# layer('straight', steelID, numBarsInt, barArea, -coreY + DisBarL, -coreZ, coreY - DisBarL + 0.01, -coreZ)
# layer('straight', steelID, numBarsTop, barArea, coreY, coreZ, coreY, -coreZ)
# layer('straight', steelID, numBarsBot, barArea, -coreY, coreZ, -coreY, -coreZ)


# some parameters
# colWidth = 0.15
# colDepth = 0.24

# cover = 0.015
# As = 0.000314  # area of no. 7 bars

# # some variables derived from the parameters
# y1 = colDepth / 2.0
# z1 = colWidth / 2.0


# section('Fiber', 3000,'-GJ', 1.e10)

# # Create the concrete core fibers
# patch('rect', 20000, 10, 1, cover - y1, cover - z1, y1 - cover, z1 - cover)

# # Create the concrete cover fibers (top, bottom, left, right)
# patch('rect', 20000, 10, 1, -y1, z1 - cover, y1, z1)
# patch('rect', 20000, 10, 1, -y1, -z1, y1, cover - z1)
# patch('rect', 20000, 2, 1, -y1, cover - z1, cover - y1, z1 - cover)
# patch('rect', 20000, 2, 1, y1 - cover, cover - z1, y1, z1 - cover)

# # Create the reinforcing fibers (left, middle, right)
# layer('straight',  60000, 3, As, y1 - cover, z1 - cover, y1 - cover, cover - z1)
# layer('straight', 60000, 2, As, 0.0, z1 - cover, 0.0, cover - z1)
# layer('straight', 60000, 3, As, cover - y1, z1 - cover, cover - y1, cover - z1)
# # from openseespy.opensees import *

# Define constants
# fc = -52.0e6
# Ec = 33892180000.0
# nu = 0.2
# Gc = Ec / (2.0 * (1 + nu))

# # # Define materials
# uniaxialMaterial('Concrete02', 20000, fc, -0.002801329, -14.5896e6, -0.014006643, 0.1, 4.617798447e6, 1590115.428)

# uniaxialMaterial('Steel02', 60000, 491.5e6, 2.0e11, 0.02, 20, 0.925, 0.15)


# # Define section tags
# BeamSecAggTag = 1000
# GirdSecAggTag = 101
# BeamSecTagFiber = 901
# GirdSecTagFiber = 9001
# matTagTorsion = 70
# Ubig = 1.0e10


# # # Core concrete (confined)
# # uniaxialMaterial('Concrete01', 1, -6.0, -0.004, -5.0, -0.014)

# # # Cover concrete (unconfined)
# # uniaxialMaterial('Concrete01', 2, -5.0, -0.002, 0.0, -0.006)

# # STEEL
# # # Reinforcing steel
# # fy = 60.0;  # Yield stress
# # E = 30000.0;  # Young's modulus
# # #                         tag  fy E0    b
# # uniaxialMaterial('Steel01', 3, fy, E, 0.01)


#  some parameters
# colWidth = 15
# colDepth = 24

# cover = 1.5
# As = 0.60  # area of no. 7 bars

# # some variables derived from the parameters
# y1 = colDepth / 2.0
# z1 = colWidth / 2.0


# section('Fiber', 3000,'-GJ', 1.e10)

# # Create the concrete core fibers
# patch('rect', 20000, 10, 1, cover - y1, cover - z1, y1 - cover, z1 - cover)

# # Create the concrete cover fibers (top, bottom, left, right)
# patch('rect', 20000, 10, 1, -y1, z1 - cover, y1, z1)
# patch('rect', 20000, 10, 1, -y1, -z1, y1, cover - z1)
# patch('rect', 20000, 2, 1, -y1, cover - z1, cover - y1, z1 - cover)
# patch('rect', 20000, 2, 1, y1 - cover, cover - z1, y1, z1 - cover)

# # Create the reinforcing fibers (left, middle, right)
# layer('straight',  60000, 3, As, y1 - cover, z1 - cover, y1 - cover, cover - z1)
# layer('straight', 60000, 2, As, 0.0, z1 - cover, 0.0, cover - z1)
# layer('straight', 60000, 3, As, cover - y1, z1 - cover, cover - y1, cover - z1)
# ################## nominal concrete compressive strength ##############
# fc =   -65.e6
# Ec =  37892611417
# nu = 0.2
# Gc =  37892611417/(2.*(1+0.2))
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 300 , 394714702.26041675)
# #UNCONFINED CONCRETE
# fc1C = -65.e6
# eps1C = -0.003846016
# fc2C = -19.5875e6
# eps2C = -0.019230082
# epsc0 = 0.003846016
# ftC = 5.038911093e6
# ftU = 1.679637031e6
# Ets = 1.679637031e6/0.003846016
# UCconcrete = 1
# uniaxialMaterial ( 'Concrete02' , 1 , -65.e6 , -0.003846016 , -19.5875e6 , -0.019230082 , 0.1 , 5.038911093e6 , 436721280.1506806)
# Fy = 491.5e6
# Es = 200.0e9
# Bs = 0.02
# Bs = 0.02
# cR1 = 0.925
# cR2 = 0.15
# RebarMatTag = 400
# uniaxialMaterial ( 'Steel02' , 400 , 491.5e6 , 200.0e9 , 0.02 , 20 , 0.925 , 0.15)
# #P19,P22,P23,P26,P20,P21,P24,P25
# fc1C = -88.17e6
# eps1C = -0.006757033
# fc2C = -35.17e6
# eps2C =  -0.010406166
# epsc0 = 0.006757033
# #tensile - Strength properties
# ftC = 5.868680111e6
# ftU = 1.956226704e6
# Ets = 1.956226704e6/0.006757033
# CCp19p22p23p26 = 2
# uniaxialMaterial ( 'Concrete02' , 2 , -88.17e6 , -0.006757033 , -35.17e6 , -0.010406166 , 0.1 , 5.868680111e6 , 289509715.8767761)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 301 , 459713275.39583343)
# #P1,P2,P3,P4---1
# fc1C = -88.72e6
# eps1C = -0.006826154
# fc2C = -35.54e6
# eps2C =  -0.010470608
# epsc0 = 0.006826154
# #tensile - Strength properties
# ftC = 5.88695592e6
# ftU = 1.96231864e6
# Ets = 1.96231864e6/0.006826154
# CCp1p2p3p41 = 3
# uniaxialMaterial ( 'Concrete02' , 3 , -88.72e6 , -0.006826154 , -35.54e6 , -0.010470608 , 0.1 , 5.88695592e6 , 287470607.90014404)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 302 ,461144880.375)
# #P1,P2,P3,P4,P5,P9,P10,P14,P37,P38,P39,P40---2
# fc1C = -88.01e6
# eps1C = -0.006727143
# fc2C = -35.01e6
# eps2C =  -0.01037764
# epsc0 = 0.006727143
# #tensile - Strength properties
# ftC = 5.863352816e6
# ftU = 1.954450939e6
# Ets = 1.954450939e6/0.006727143
# CCp1p2p3p42 = 4
# uniaxialMaterial ( 'Concrete02' , 4 , -88.01e6 , -0.006727143 , -35.01e6 , -0.01037764 , 0.1 , 5.863352816e6 , 290532093.4905056)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 303 , 459295970.625)
# #P5,P9,P10,P14,P6,P8,P11,P13,P31,P35---1
# fc1C = -88.79e6
# eps1C = -0.006872857
# fc2C = -35.79e6
# eps2C =  -0.010516717
# epsc0 = 0.006872857
# #tensile - Strength properties
# ftC = 5.889277863e6
# ftU = 1.963092621e6
# Ets = 1.963092621e6/0.006872857
# CCp5p9p10p141 = 5
# uniaxialMaterial ( 'Concrete02' , 5 , -88.79e6 , -0.006872857 , -35.79e6 , -0.010516717 , 0.1 , 5.889277863e6 , 285629778.2712488)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 304 , 461326765.94791675)
# #P6,P8,P11,P13,P7,P12---2
# fc1C = -87.66e6
# eps1C = -0.006661758
# fc2C = -34.66e6
# eps2C =  -0.010315243
# epsc0 = 0.006661758
# #tensile - Strength properties
# ftC = 5.85168245e6
# ftU = 1.950560817e6
# Ets = 1.950560817e6/0.006661758
# CCp6p8p11p132 = 6
# uniaxialMaterial ( 'Concrete02' , 6 , -87.66e6 , -0.006661758 , -34.66e6 , -0.010315243 , 0.1 , 5.85168245e6 , 292799710.9771925)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 305 , 458381791.94791675)
# #P7,P12---1
# fc1C = -88.11e6
# eps1C = -0.006745824
# fc2C = -35.11e6
# eps2C =  -0.010395468
# epsc0 = 0.006745824
# #tensile - Strength properties
# ftC = 5.866682943e6
# ftU = 1.955560981e6
# Ets = 1.955560981e6/0.006745824
# CCp7p12 = 7
# uniaxialMaterial ( 'Concrete02' , 7 , -88.11e6 , -0.006745824 , -35.11e6 , -0.010395468 , 0.1 , 5.866682943e6 , 289892084.4955338)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 306 , 458381791.94791675)
# #P37,P38,P39,P40---1
# fc1C = -88.54e6
# eps1C = -0.006826154
# fc2C = -35.54e6
# eps2C =  -0.010472138
# epsc0 = 0.006826154
# #tensile - Strength properties
# ftC = 5.866682943e6
# ftU = 1.960326999e6
# Ets = 1.960326999e6/0.006826154
# CCp37p38p39p40 = 8
# uniaxialMaterial ( 'Concrete02' , 8 , -88.54e6 , -0.006826154 , -35.54e6 , -0.010472138 , 0.1 , 5.880980998e6 , 287178841.70207703)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 307 , 458381791.94791675)
# #P27,P28,P29,P30
# fc1C = -88.61e6
# eps1C = -0.006839231
# fc2C = -35.5435e6
# eps2C =  -0.01048462
# epsc0 = 0.006839231
# #tensile - Strength properties
# ftC = 5.8833053e6
# ftU = 1.961101767e6
# Ets = 1.961101767e6/0.006839231
# CCp27p28p29p30 = 9
# uniaxialMaterial ( 'Concrete02' , 9 , -88.61e6 , -0.006839231 , -35.5435e6 , -0.01048462 , 0.1 , 5.8833053e6 , 286743022.2783819)
# #P19,P22,P23,P26 shear stiffness
# k = 0.025
# uniaxialMaterial ( 'Elastic' , 308 , 460858915.14583343)


# exec(open("BeamSecMat.py").read())
# exec(open("BuildRCrectSection.py").read())

# exec(open("SWsection.py").read())
 exec(open("shearwallsections.py").read())
 exec(open("RCStory3D.py").read())
# exec(open("DefineBeamLoading.py").read())
# vfo.plot_model()

# import  mat.py
# import  RC3D1Story.py

# Eigenvalue analysis
# eigen(1)
# T1model = 2 * 3.1416 / math.sqrt(ops.eigen(1)[0])
# print(f'T1model={T1model} sec')


# pi=3.14
 pi = math.pi
# print(pi)
 num_eig = 1
 eig = eigen(num_eig)
 T = []
 W = []
 for e in range(0, num_eig):
     T.append((2 * pi) / (eig[e]) ** 0.5)
     W.append(math.sqrt(eig[e]))

 print("moodal OK")

 modalDamping(0.025)

 print("damping OK")

# vfo.plot_model()
# opsvis.plot_model(node_labels=1, element_labels=0)
# opsvis.plot_defo()

# eigen = eigen('-fullGenLapack', 2)
# system('BandGeneral')
# eigen = eigen('-genBandArpack', 10)
# eig = eigen('-genBandArpack', 10)
# eig = eigen(10)
# W1 = math.pow(eigen[0], 0.5)
# print ("W1=", W1)
# W2 = math.pow(eigen[1], 0.5)
# print ("W2=", W2)
# # Apply Rayleigh damping
# xDamp = 0.025
# alphaM = (2*xDamp*W1*W2)/(W1+W2)
# betaKcomm = 2.0*xDamp /(W1+W2)
# betaK=0.0
# betaKinit=0.0
# #rayleigh(alphaM, betaK, betaKinit, betaKcomm)
# rayleigh(alphaM, betaK, betaKinit, betaKcomm)
# print("damping OK")


# # Damping parameters
# xDamp = 0.025
# MpropSwitch = 1.0
# KcurrSwitch = 0.0
# KcommSwitch = 1.0
# KinitSwitch = 0.0
# nEigenI = 1
# nEigenJ = 1
# lambdaN = ops.eigen(nEigenJ)
# lambdaI = lambdaN[nEigenI - 1]
# lambdaJ = lambdaN[nEigenJ - 1]
# omegaI = math.sqrt(lambdaI)
# omegaJ = math.sqrt(lambdaJ)
# alphaM = MpropSwitch * xDamp * (2 * omegaI * omegaJ) / (omegaI + omegaJ)
# betaKcurr = KcurrSwitch * 2.0 * xDamp / (omegaI + omegaJ)
# betaKcomm = KcommSwitch * 2.0 * xDamp / (omegaI + omegaJ)
# betaKinit = KinitSwitch * 2.0 * xDamp / (omegaI + omegaJ)
# rayleigh(alphaM, betaKcurr, betaKinit, betaKcomm)


# Set damping
# ------------------------------------------------------------------------
# Using mass and committed stiffness proportional damping
# rayleigh coefficients are calculated based on first two modes
# xi = 0.025                               # Damping ratio
# Lambda = ops.eigen('-genBandArpack', 2) # Eigen values
# w1 = Lambda[0]**0.5                     # Natural circular frequency for the 1st mode
# w2 = Lambda[1]**0.5                     # Natural circular frequency for the 2nd mode
# alpha = 2.0 * xi * w1 * w2 / (w1 + w2)  # Factor applied to elements or nodes mass matrix
# beta = 2.0 * xi / (w1 + w2)             # Factor applied to elements commited stiffness matrix
# ops.rayleigh(alpha, 0.0, 0.0, beta)     # Assign rayleigh damping

#  # set damping based on first eigen mode
# eigen_1 = op.eigen('-genBandArpack', 1)
# angular_freq = eigen_1[0] ** 0.5
# alpha_m = 0.0
# beta_k = 2 * xi / angular_freq
# beta_k_comm = 0.0
# beta_k_init = 0.0

# op.rayleigh(alpha_m, beta_k, beta_k_init, beta_k_comm)

# Defining Damping
# Applying Rayleigh Damping from $xDamp
# D=$alphaM*M + $betaKcurr*Kcurrent + $betaKcomm*KlastCommit + $beatKinit*$Kinitial
# xDamp = 0.025;								# 5% damping ratio
# alphaM 		= 0.;								# M-prop. damping; D = alphaM*M
# betaKcurr 	= 0.;         						# K-proportional damping;      +beatKcurr*KCurrent
# betaKcomm 	= 2.*xDamp/omega;   				# K-prop. damping parameter;   +betaKcomm*KlastCommitt
# betaKinit 	= 0.;         						# initial-stiffness proportional damping      +beatKinit*Kini
# rayleigh(alphaM,betaKcurr,betaKinit,betaKcomm); # RAYLEIGH damping



# opsvis.plot_model(node_labels=0, element_labels=0)


# #_______________________________________________________

# timeSeries('Linear', tag, '-factor', factor=1.0, '-tStart', tStart=0.0)
# timeSeries('Linear', 1)


# # pattern('Plain', patternTag, tsTag, '-fact', fact)
# # eleLoad('-ele', *eleTags, '-range', eleTag1, eleTag2, '-type', '-beamUniform', Wy, <Wz>, Wx=0.0, '-beamPoint', Py, <Pz>, xL, Px=0.0, '-beamThermal', *tempPts)
# pattern('Plain', 1, 1)
# Wy=-4.526e3

# eleTags=[    1001130, 1000249, 1000347, 1000455, 1000548, 1000650, 1002730, 1300813, 1300991,
#     1301095, 1301195, 1301292, 1301314, 1001501, 2709, 103615, 102715, 2909, 1002002,
#     1102070, 1102178, 1002278, 1002370]


# eleLoad('-ele', *eleTags, '-type', '-beamUniform', Wy, 0.0, 0.0)


# # Define beam loading pattern
# # timeSeries('Linear', 1)
# # pattern('Plain', 1, 1)
# # from openseespy.opensees import *

# # Define pattern
# pattern('Plain', 101)

# # List of element IDs
# element_ids = [
#     1001130, 1000249, 1000347, 1000455, 1000548, 1000650, 1002730, 1300813, 1300991,
#     1301095, 1301195, 1301292, 1301314, 1001501, 2709, 103615, 102715, 2909, 1002002,
#     1102070, 1102178, 1002278, 1002370
# ]

# # Load magnitude
# load_magnitude = -4.526e3

# # Apply uniform beam load to each element
# for ele_id in element_ids:
#     eleLoad('-ele', ele_id, '-type', '-beamUniform', load_magnitude, 0.0)


# num_cores = multiprocessing.cpu_count()

# stime = time.time()


# Static Analysis parameters
 ops.wipeAnalysis()
 ops.constraints('Transformation')
 ops.numberer('RCM')
 ops.system('SparseGeneral')
 ops.test('NormDispIncr', 1.0e-5, 10)
 ops.algorithm('ModifiedNewton')
 ops.integrator('LoadControl', 0.1)
 ops.analysis('Static')
 ops.analyze(10)
 ops.loadConst('-time', 0.0)

 print("Gravity OK")

 file_1 = pathlib.Path("timehistory_output4")
 if file_1.exists():
    shutil.rmtree("timehistory_output4")
 os.mkdir("timehistory_output4")
# recorder('Node', '-file', 'timehistory_output4/disp9901.txt', '-node', 9901, '-dof', 1, 'disp')
# recorder('Node', '-file', 'timehistory_output4/disp9930.txt', '-node', 9930, '-dof', 1, 'disp')
# recorder('Node', '-file', 'timehistory_output4/disp9929.txt', '-node', 9929, '-dof', 1, 'disp')


# Define earthquake excitation
# mm = 2
# accelX = f'Series -dt 0.01 -filePath R11-900X-dt=0.01-Et=21.99-pga=1.txt -factor {mm * 9.86 / 10}'
# accelZ = f'Series -dt 0.01 -filePath R11-900X-dt=0.01-Et=21.99-pga=1.txt -factor {mm * 9.86 / 10}'

# ops.pattern('UniformExcitation', 3, 1, '-accel', accelX)
# ops.pattern('UniformExcitation', 4, 3, '-accel', accelZ)




 ts = 0.01
 ops.timeSeries('Path', 10, '-filePath', 'RSN6_IMPVALL.I_I-ELC180_IDA1.txt', '-dt', ts, '-factor', (mm / 10) * 9.86)
 ops.pattern('UniformExcitation', 3, 1, '-accel', 10, '-fact', 1)

 ops.timeSeries('Path', 11, '-filePath', 'RSN6_IMPVALL.I_I-ELC270_IDA2.txt', '-dt', ts, '-factor', (mm / 10) * 9.86)
 ops.pattern('UniformExcitation', 4, 3, '-accel', 11, '-fact', 1)

 print(f'groundmotion start!. Time: {ops.getTime()}')



# ---------story displacement--------
# ---------X dir--------
 recorder('Node', '-file', 'timehistory_output4/dispX9901.txt', '-timeSeries', 10, '-node', 9901, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9902.txt', '-timeSeries', 10, '-node', 9902, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9903.txt', '-timeSeries', 10, '-node', 9903, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9904.txt', '-timeSeries', 10, '-node', 9904, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9905.txt', '-timeSeries', 10, '-node', 9905, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9906.txt', '-timeSeries', 10, '-node', 9906, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9907.txt', '-timeSeries', 10, '-node', 9907, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9908.txt', '-timeSeries', 10, '-node', 9908, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9909.txt', '-timeSeries', 10, '-node', 9909, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9910.txt', '-timeSeries', 10, '-node', 9910, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9911.txt', '-timeSeries', 10, '-node', 9911, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9912.txt', '-timeSeries', 10, '-node', 9912, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9913.txt', '-timeSeries', 10, '-node', 9913, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9914.txt', '-timeSeries', 10, '-node', 9914, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9915.txt', '-timeSeries', 10, '-node', 9915, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9916.txt', '-timeSeries', 10, '-node', 9916, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9917.txt', '-timeSeries', 10, '-node', 9917, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9918.txt', '-timeSeries', 10, '-node', 9918, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9919.txt', '-timeSeries', 10, '-node', 9919, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9920.txt', '-timeSeries', 10, '-node', 9920, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9921.txt', '-timeSeries', 10, '-node', 9921, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9922.txt', '-timeSeries', 10, '-node', 9922, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9923.txt', '-timeSeries', 10, '-node', 9923, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9924.txt', '-timeSeries', 10, '-node', 9924, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9925.txt', '-timeSeries', 10, '-node', 9925, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9926.txt', '-timeSeries', 10, '-node', 9926, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9927.txt', '-timeSeries', 10, '-node', 9927, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9928.txt', '-timeSeries', 10, '-node', 9928, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9929.txt', '-timeSeries', 10, '-node', 9929, '-dof', 1, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispX9930.txt', '-timeSeries', 10, '-node', 9930, '-dof', 1, 'disp')
# ---------Y dir--------
 recorder('Node', '-file', 'timehistory_output4/dispY9901.txt', '-timeSeries', 11, '-node', 9901, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9902.txt', '-timeSeries', 11, '-node', 9902, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9903.txt', '-timeSeries', 11, '-node', 9903, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9904.txt', '-timeSeries', 11, '-node', 9904, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9905.txt', '-timeSeries', 11, '-node', 9905, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9906.txt', '-timeSeries', 11, '-node', 9906, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9907.txt', '-timeSeries', 11, '-node', 9907, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9908.txt', '-timeSeries', 11, '-node', 9908, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9909.txt', '-timeSeries', 11, '-node', 9909, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9910.txt', '-timeSeries', 11, '-node', 9910, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9911.txt', '-timeSeries', 11, '-node', 9911, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9912.txt', '-timeSeries', 11, '-node', 9912, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9913.txt', '-timeSeries', 11, '-node', 9913, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9914.txt', '-timeSeries', 11, '-node', 9914, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9915.txt', '-timeSeries', 11, '-node', 9915, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9916.txt', '-timeSeries', 11, '-node', 9916, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9917.txt', '-timeSeries', 11, '-node', 9917, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9918.txt', '-timeSeries', 11, '-node', 9918, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9919.txt', '-timeSeries', 11, '-node', 9919, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9920.txt', '-timeSeries', 11, '-node', 9920, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9921.txt', '-timeSeries', 11, '-node', 9921, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9922.txt', '-timeSeries', 11, '-node', 9922, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9923.txt', '-timeSeries', 11, '-node', 9923, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9924.txt', '-timeSeries', 11, '-node', 9924, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9925.txt', '-timeSeries', 11, '-node', 9925, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9926.txt', '-timeSeries', 11, '-node', 9926, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9927.txt', '-timeSeries', 11, '-node', 9927, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9928.txt', '-timeSeries', 11, '-node', 9928, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9929.txt', '-timeSeries', 11, '-node', 9929, '-dof', 3, 'disp')
 recorder('Node', '-file', 'timehistory_output4/dispY9930.txt', '-timeSeries', 11, '-node', 9930, '-dof', 3, 'disp')
# ---------X dir--------
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9901.txt', '-timeSeries', 10, '-node', 9901, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9902.txt', '-timeSeries', 10, '-node', 9902, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9903.txt', '-timeSeries', 10, '-node', 9903, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9904.txt', '-timeSeries', 10, '-node', 9904, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9905.txt', '-timeSeries', 10, '-node', 9905, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9906.txt', '-timeSeries', 10, '-node', 9906, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9907.txt', '-timeSeries', 10, '-node', 9907, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9908.txt', '-timeSeries', 10, '-node', 9908, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9909.txt', '-timeSeries', 10, '-node', 9909, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9910.txt', '-timeSeries', 10, '-node', 9910, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9911.txt', '-timeSeries', 10, '-node', 9911, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9912.txt', '-timeSeries', 10, '-node', 9912, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9913.txt', '-timeSeries', 10, '-node', 9913, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9914.txt', '-timeSeries', 10, '-node', 9914, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9915.txt', '-timeSeries', 10, '-node', 9915, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9916.txt', '-timeSeries', 10, '-node', 9916, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9917.txt', '-timeSeries', 10, '-node', 9917, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9918.txt', '-timeSeries', 10, '-node', 9918, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9919.txt', '-timeSeries', 10, '-node', 9919, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9920.txt', '-timeSeries', 10, '-node', 9920, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9921.txt', '-timeSeries', 10, '-node', 9921, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9922.txt', '-timeSeries', 10, '-node', 9922, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9923.txt', '-timeSeries', 10, '-node', 9923, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9924.txt', '-timeSeries', 10, '-node', 9924, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9925.txt', '-timeSeries', 10, '-node', 9925, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9926.txt', '-timeSeries', 10, '-node', 9926, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9927.txt', '-timeSeries', 10, '-node', 9927, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9928.txt', '-timeSeries', 10, '-node', 9928, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9929.txt', '-timeSeries', 10, '-node', 9929, '-dof', 1,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispX9930.txt', '-timeSeries', 10, '-node', 9930, '-dof', 1,
         'disp')
# ---------Y dir--------
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9901.txt', '-timeSeries', 11, '-node', 9901, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9902.txt', '-timeSeries', 11, '-node', 9902, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9903.txt', '-timeSeries', 11, '-node', 9903, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9904.txt', '-timeSeries', 11, '-node', 9904, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9905.txt', '-timeSeries', 11, '-node', 9905, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9906.txt', '-timeSeries', 11, '-node', 9906, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9907.txt', '-timeSeries', 11, '-node', 9907, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9908.txt', '-timeSeries', 11, '-node', 9908, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9909.txt', '-timeSeries', 11, '-node', 9909, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9910.txt', '-timeSeries', 11, '-node', 9910, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9911.txt', '-timeSeries', 11, '-node', 9911, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9912.txt', '-timeSeries', 11, '-node', 9912, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9913.txt', '-timeSeries', 11, '-node', 9913, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9914.txt', '-timeSeries', 11, '-node', 9914, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9915.txt', '-timeSeries', 11, '-node', 9915, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9916.txt', '-timeSeries', 11, '-node', 9916, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9917.txt', '-timeSeries', 11, '-node', 9917, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9918.txt', '-timeSeries', 11, '-node', 9918, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9919.txt', '-timeSeries', 11, '-node', 9919, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9920.txt', '-timeSeries', 11, '-node', 9920, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9921.txt', '-timeSeries', 11, '-node', 9921, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9922.txt', '-timeSeries', 11, '-node', 9922, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9923.txt', '-timeSeries', 11, '-node', 9923, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9924.txt', '-timeSeries', 11, '-node', 9924, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9925.txt', '-timeSeries', 11, '-node', 9925, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9926.txt', '-timeSeries', 11, '-node', 9926, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9927.txt', '-timeSeries', 11, '-node', 9927, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9928.txt', '-timeSeries', 11, '-node', 9928, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9929.txt', '-timeSeries', 11, '-node', 9929, '-dof', 3,
         'disp')
 recorder('EnvelopeNode', '-file', 'timehistory_output4/ENVdispY9930.txt', '-timeSeries', 11, '-node', 9930, '-dof', 3,
         'disp')





 algorithms =['KrylovNewton','Newton', 'NewtonLineSearch', 'ModifiedNewton', 'SecantNewton', 'RaphsonNewton', 'PeriodicNewton', 'BFGS']

# # # THA Solver

 wipeAnalysis()
 constraints('Transformation')
 numberer('RCM')
 system('SparseGeneral')
 tol = 1.e-4
 test('EnergyIncr', 1.e-4, 20)
# test('NormDispIncr', tol, 200, 2)
 defaultAlgorithmType = 'KrylovNewton'
 algorithm(defaultAlgorithmType)
 integrator('Newmark', 0.5, 0.25)
 analysis('Transient')

 print(f'groundmotion start!. Time: {ops.getTime()}')

# Set parameters
 Endtime = 27
 dt = 0.01
 nt = int(Endtime / dt)

 dteq = 0.01
 q = 2700
 record_length = dteq * q
 tFinal = Endtime

# Perform the transient analysis
 tCurrent = getTime()
 ok = 0

## Start timing
 begin = time.time()

 while ok == 0 and tCurrent < tFinal:
    ok = analyze(1, dt)
    print(getTime())

    # if the analysis fails try initial tangent iteration
    if ok != 0:
        for algo in algorithms:
          print("regular time step failed .. defaultAlgorithmType  lets try a smaller step and a less stringent test")
          constraints('Transformation')
          numberer('RCM')
          system('SparseGeneral')
          test('NormDispIncr', 1.0e-1, 500, 1)
          ops.algorithm(algo)
          ok = analyze(1, dt * 0.1)

          if ok != 0:
             for algo in algorithms:
               print("regular time step failed .. Newton lets try a smaller step and a less stringent test")
               constraints('Transformation')
               numberer('RCM')
               system('SparseGeneral')
               test('NormDispIncr', 1.0e-1, 500, 1)
               ops.algorithm(algo)
               ok = analyze(1, dt * 0.01)

               if ok != 0:
                 for algo in algorithms:
                   print("regular time step failed .. NewtonLineSearch lets try a smaller step and a less stringent test")
                   constraints('Transformation')
                   numberer('RCM')
                   system('SparseGeneral')
                   test('NormDispIncr', 1.0e-1, 500, 1)
                   ops.algorithm(algo)
                   ok = analyze(1, dt * 0.001)

                   if ok != 0:
                     for algo in algorithms:
                       print("regular time step failed .. ModifiedNewton lets try a smaller step and a less stringent test")
                       constraints('Transformation')
                       numberer('RCM')
                       system('SparseGeneral')
                       test('NormDispIncr', 1.0e-1, 500, 1)
                       ops.algorithm(algo)
                       ok = analyze(1, dt * 0.0001)

                       if ok != 0:
                         for algo in algorithms:
                            print("regular time step failed .. SecantNewton lets try a smaller step and a less stringent test")
                            constraints('Transformation')
                            numberer('RCM')
                            system('SparseGeneral')
                            test('NormDispIncr', 1.0e-1, 500, 1)
                            ops.algorithm(algo)
                            ok = analyze(1, dt * 0.00001)

                            if ok != 0:
                              for algo in algorithms:
                                print("regular time step failed .. RaphsonNewton lets try a smaller step and a less stringent test")
                                constraints('Transformation')
                                numberer('RCM')
                                system('SparseGeneral')
                                test('NormDispIncr', 1.0e-1, 500, 1)
                                ops.algorithm(algo)
                                ok = analyze(1, dt * 0.000001)



          if ok == 0:
             print("that worked .. back to regular time step and test criteria")
             test('NormDispIncr', 1.0e-2, 100)
             ok = analyze(1, dt)

    tCurrent = getTime()

# Print a message to indicate if analysis successful or not
 if ok == 0:
    print("################################################")
    print("Transient analysis completed SUCCESSFULLY")
    print("################################################")
 else:
    print("################################################")
    print("Transient analysis FAILED")
    print("################################################")

# End timing
 endt = time.time()
 totaltime = endt - begin
 totaltimem = totaltime / 60.0

 print(f"Time in hours: {totaltimem / 60.}")
 print(f"{totaltimem} is the total time in minutes")

# num_cores = 16
# Parallel(n_jobs=num_cores)(delayed(dynamic_analysis)() for _ in range(num_cores))


# wipe()

# ops.constraints('Lagrange')
# ops.numberer('RCM')
# # ops.system('SparseGeneral')
# ops.system('BandGen')
# ops.test('NormDispIncr', 1.0e-4, 100)
# # ops.test('EnergyIncr', 1.0e-4, 100)
# #ops.algorithm('ModifiedNewton')
# algorithm('KrylovNewton')
# ops.integrator('Newmark', 0.5, 0.25)
# ops.analysis('Transient')
# ops.analyze(nt,dt)

# print(f'groundmotion done!. End Time: {ops.getTime()}')

# THA Solver
# wipeAnalysis()
# ops.constraints('Transformation')
# ops.numberer('RCM')
# ops.system('SparseGeneral')
# tol = 1.e-4
# test('EnergyIncr', 1.e-4, 20)
# defaultAlgorithmType = 'KrylovNewton'
# ops.algorithm(defaultAlgorithmType)
# ops.integrator('Newmark', 0.5, 0.25)
# ops.analysis('Transient')

# dt = 0.1
# Nsteps = int(21.99 / dt)
# step1 = 10
# dt1 = dt / step1
# ok = ops.analyze(int(nt / dt),dt)
# tFinal = Endtime

# # Perform the transient analysis
# tCurrent = getTime()
# ok = 0

# # Start timing
# begin = time.time()

# while ok == 0 and tCurrent < tFinal:
#  for step in range(1, Nsteps + 1):

#   if ok != 0:
#         print('\n******************* reduced time step dt/n ******************\n')
#         ops.test('NormDispIncr', 1.0e-1,  165, 1)
#         for i in range(1, step1 + 1):
#             print(f'\nTrying {defaultAlgorithmType} (dt/n)...\n')
#             ops.algorithm(defaultAlgorithmType)
#             ok = ops.analyze(1/ dt1)
#             if ok != 0:
#                 print(f'\nTrying Newton with Initial Tangent (dt/n)...\n')
#                 ops.algorithm('Newton', '-initial')
#                 ok = ops.analyze(1 / dt1)
#             if ok != 0:
#                 print(f'\nTrying Broyden (dt/n)...\n')
#                 ops.algorithm('Broyden', 8)
#                 ok = ops.analyze(1 / dt1)
#             if ok != 0:
#                 print(f'\nTrying NewtonWithLineSearch (dt/n)...\n')
#                 ops.algorithm('NewtonLineSearch', 0.8)
#                 ok = ops.analyze(1 / dt1)
#             if ok != 0:
#                 print(f'\nTrying ModifiedNewton (dt/n)...\n')
#                 ops.algorithm('ModifiedNewton')
#                 ok = ops.analyze(1 / dt1)
#         print('\n******************* normal time step dt ******************\n')
# ops.test('NormDispIncr', 1.0e-3, 50)
# ops.algorithm(defaultAlgorithmType)

# tCurrent = getTime()

# print('\n\nTIME HISTORY ANALYSIS DONE.')
# print(f'groundmotion done!. End Time: {ops.getTime()}')

# Set parameters
# dt = 0.01
# dteq = 0.01
# q = 3000
# record_length = dteq * q
# tFinal = 21.99

# # Perform the transient analysis
# tCurrent = getTime()
# ok = 0

# # Start timing
# begin = time.time()

# while ok == 0 and tCurrent < tFinal:
#     ok = analyze(1, dt)
#     print(getTime())

#     # if the analysis fails try initial tangent iteration
#     if ok != 0:
#         print("regular time step failed .. lets try a smaller step and a less stringent test")
#         test('NormDispIncr', 1.0e-1, 165, 1)
#         ok = analyze(1, dt * 0.005)
#         if ok == 0:
#             print("that worked .. back to regular time step and test criteria")
#         test('NormDispIncr', 1.0e-3, 50)

#     tCurrent = getTime()

# # Print a message to indicate if analysis successful or not
# if ok == 0:
#     print("################################################")
#     print("Transient analysis completed SUCCESSFULLY")
#     print("################################################")
# else:
#     print("################################################")
#     print("Transient analysis FAILED")
#     print("################################################")

# # End timing
# endt = time.time()
# totaltime = endt - begin
# totaltimem = totaltime / 60.0

# print(f"Time in hours: {totaltimem / 60.}")
# print(f"{totaltimem} is the total time in minutes")

wipe()

parameter_list = [6, 8, 10, 12 , 14 , 16 , 18 , 20]  # list of frame height parameters
# algorithms = ['KrylovNewton','Newton', 'NewtonLineSearch', 'ModifiedNewton', 'SecantNewton', 'RaphsonNewton', 'PeriodicNewton', 'BFGS']

def Parallel_Analysis():
    with ProcessPoolExecutor() as executor:
        ### submit all tasks
        for mm in parameter_list:
            p = executor.submit(myParallelModel, mm)

# def Parallel_Analysis():
#     with ThreadPoolExecutor() as executor:
#         ### submit all tasks
#         for algorithm in algorithms:
#             p = executor.submit(myParallelModel, algorithm)

if __name__ == '__main__':
    Parallel_Analysis()
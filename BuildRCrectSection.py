from openseespy.opensees import *

# Procedure to build RC rectangular section
def BuildRCrectSection(SecTag, BSec, HSec, cover, coreID, coverID, steelID, totalnumBars, barDiameter, numBarsTop, numBarsBot, nfCoreY, nfCoreZ, nfCoverY, nfCoverZ):
    coverY = HSec / 2.0
    coverZ = BSec / 2.0
    coreY = coverY - cover
    coreZ = coverZ - cover
    numBarsInt = int( totalnumBars - (numBarsTop + numBarsBot) / 2)
    barArea = 3.14 * pow(barDiameter, 2) / 4.0
    DisBarL = (HSec - 2 * cover) / (numBarsInt + 1)

    GJ = 1.e10
    section('Fiber', SecTag ,'-GJ',GJ)
    # Define fiber section
    patch('quad', coreID, nfCoreZ, nfCoreY, -coreY, coreZ, -coreY, -coreZ, coreY, -coreZ, coreY, coreZ)
    patch('quad', coverID, 2, nfCoverY, -coverY, coverZ, -coreY, coreZ, coreY, coreZ, coverY, coverZ)
    patch('quad', coverID, 2, nfCoverY, -coreY, -coreZ, -coverY, -coverZ, coverY, -coverZ, coreY, -coreZ)
    patch('quad', coverID, nfCoverZ, 2, -coverY, coverZ, -coverY, -coverZ, -coreY, -coreZ, -coreY, coreZ)
    patch('quad', coverID, nfCoverZ, 2, coreY, coreZ, coreY, -coreZ, coverY, -coverZ, coverY, coverZ)

    layer('straight', steelID, numBarsInt, barArea, -coreY + DisBarL, coreZ, coreY - DisBarL + 0.01, coreZ)
    layer('straight', steelID, numBarsInt, barArea, -coreY + DisBarL, -coreZ, coreY - DisBarL + 0.01, -coreZ)
    layer('straight', steelID, numBarsTop, barArea, coreY, coreZ, coreY, -coreZ)
    layer('straight', steelID, numBarsBot, barArea, -coreY, coreZ, -coreY, -coreZ)





# return
# # Define section tags
# BeamSecAggTag = 1000
# GirdSecAggTag = 101
# BeamSecTagFiber = 901
# GirdSecTagFiber = 9001
# matTagTorsion = 70
# Ubig = 1.0e10

# # Define sections for beams
# BuildRCrectSection(902, 0.40, 0.60, 0.04, 20000, 50000, 60000, 10, 0.020, 6, 4, 20, 20, 10, 10)
# BuildRCrectSection(902, 0.40, 0.60, 0.04, 20000, 50000, 60000, 12, 0.020, 7, 5, 20, 20, 10, 10)
# BuildRCrectSection(903, 0.55, 0.70, 0.04, 30000, 50000, 60000, 22, 0.022, 11, 11, 20, 20, 10, 10)
# BuildRCrectSection(904, 0.55, 0.70, 0.04, 40000, 50000, 60000, 24, 0.022, 12, 12, 20, 20, 10, 10)

# # Define sections for girders
# BuildRCrectSection(9002, 0.40, 0.60, 0.04, 20000, 50000, 60000, 19, 0.020, 10, 9, 20, 20, 10, 10)
# BuildRCrectSection(9002, 0.40, 0.60, 0.04, 20000, 50000, 60000, 20, 0.020, 10, 10, 20, 20, 10, 10)
# BuildRCrectSection(9003, 0.55, 0.70, 0.04, 30000, 50000, 60000, 30, 0.022, 15, 15, 20, 20, 10, 10)
# BuildRCrectSection(9004, 0.55, 0.70, 0.04, 40000, 50000, 60000, 24, 0.022, 12, 12, 20, 20, 10, 10)













# Assign torsional stiffness#
# matTagTorsion=70
# uniaxialMaterial('Elastic', matTagTorsion, 1.e+10)

# Aggregate sections for beams
# section('Aggregator', 2000, matTagTorsion, 'T', '-section', BeamSecTagFiber)
# section('Aggregator', 2000, matTagTorsion, 'T', '-section', 902)
# section('Aggregator', 3000, matTagTorsion, 'T', '-section', 903)
# section('Aggregator', 4000, matTagTorsion, 'T', '-section', 904)

# # Aggregate sections for girders
# section('Aggregator', 102, matTagTorsion, 'T', '-section', GirdSecTagFiber)
# section('Aggregator', 102, matTagTorsion, 'T', '-section', 9002)
# section('Aggregator', 103, matTagTorsion, 'T', '-section', 9003)
# section('Aggregator', 104, matTagTorsion, 'T', '-section', 9004)

# # Perform further actions as needed, such as defining elements and applying loads












from opensees.openseespy import *
from BuildRCrectSection import BuildRCrectSection
import vfo.vfo as vfo
import matplotlib.pyplot as plt


def MomentCurvature(secTag,axialLoad,maxK,numIncr=100):
    # Define two nodes at (0,0)
    node(1,0.0,0.0)
    node(2,0.0,0.0)

    # Fix all degrees of freedom except axial and bending
    fix(1,1,1,1)
    fix(2,0,1,0)

    # Define element
    element('zeroLengthSection',1,1,2,secTag)

    # Define constant axial load
    timeSeries('Constant',1)
    pattern('Plain',1,1)
    load(2,axialLoad,0.0,0.0)

    # Define analysis parameters
    integrator('LoadControl',0.0)
    system('SparseGeneral','-piv')
    test('NormDispIncr',1e-9,10)
    numberer('Plain')
    constraints('Plain')
    algorithm('Newton')
    analysis('Static')

    # Do one analysis for constant axial load
    analyze(1)

    # Define reference moment
    timeSeries('Linear',2)
    pattern('Plain',2,2)
    load(2,0.0,0.0,1.0)

    # Compute curvature increment
    dK=maxK/numIncr

    # Use displacement control at node 2 for section analysis
    integrator('DisplacementControl',2,3,dK,1,dK,dK)

    # Do the section analysis
    analyze(numIncr)

    # Record results
    curvatures=[]
    moments=[]
    for i in range(numIncr):
        curvatures.append(nodeDisp(2,3))
        moments.append(nodeReaction(2,3))

    return curvatures,moments


# Initialize OpenSees
wipe()
print("Start MomentCurvature.py example")

# Define model builder
model('basic','-ndm',2,'-ndf',3)

exec(open("BeamSecMat.py").read())

# Build sections
BuildRCrectSection(1000,0.40,0.60,0.04,20000,50000,60000,10,0.020,6,4,10,5,5,5)
BuildRCrectSection(2000,0.40,0.60,0.04,20000,50000,60000,12,0.020,7,5,10,5,5,5)
BuildRCrectSection(3000,0.55,0.70,0.04,30000,50000,60000,22,0.022,11,11,10,5,5,5)
BuildRCrectSection(4000,0.55,0.70,0.04,40000,50000,60000,24,0.022,12,12,10,5,5,5)

# Define some parameters
colWidth=0.4
colDepth=0.6
cover=0.04
As=0.002
d=colDepth-cover
fy=491.5e6  # Yield stress
E=200.0e9  # Young's modulus
epsy=fy/E
Ky=epsy/(0.7*d)

print("Estimated yield curvature: ",Ky)

P=0
mu=20.0
numIncr=1000

# Call the section analysis procedure
curvatures,moments=MomentCurvature(1000,P,Ky*mu,numIncr)

# Plotting the results
plt.plot(curvatures,moments,'k-*',label='Calculated')
plt.axvline(x=Ky,color='g',linestyle='--',label='Yield Curvature')
plt.legend()
plt.xlabel("Curvature")
plt.ylabel("Moment (N-m)")
plt.title("Moment-Curvature Relationship")
plt.grid(True)
plt.show()

# Save results
with open('results.out','a+') as results:
    results.write("Curvatures: {}\n".format(curvatures))
    results.write("Moments: {}\n".format(moments))

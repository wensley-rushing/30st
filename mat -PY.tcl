
file mkdir data3d



set txt [open data3d/MAT.tcl w+]



set s "################## nominal concrete compressive strength ##############"
puts $txt "$s"
set s " fc =   -52.e6" ;     # CONCRETE Compressive Strength, (Kgf/m2)   (+Tension, -Compress)
puts $txt "$s" 
set  fc    -52.e6
set s "Ec =  33892180000";   # Concrete Elastic Modulus (Kgf/m2)
puts $txt "$s" 
#chon in formol baraye vahed (kg.cm)bood aval fc ra be kg.cm tabdil kardam va dar akhar dobare be kg.m tabdil kardam 
#puts $txt "#Ec= $Ec"
set Ec  33892180000
set s " nu = 0.2"  ;
set  nu  0.2
puts $txt "$s"
set  s " Gc =  $Ec/(2.*(1+$nu))"  ;          # Torsional stiffness Modulus
puts $txt "$s"
set  Gc [expr  $Ec/(2.*(1+$nu))]


set s "#BEAM IN ALL STORIES  B40x60"
puts $txt "$s"


set s " fc1C = -54.5896e6" ;                     # CONFINED concrete (mander model), maximum stress
puts $txt "$s"
set  fc1C  -54.5896e6
set s " eps1C = -0.002801329" ;      # strain at maximum stress 
puts $txt "$s"
set eps1C  -0.002801329
set s " fc2C = -14.5896e6"
puts $txt "$s"
set  fc2C  -14.5896e6
set s " eps2C =  -0.014006643";		# strain at ultimate stress 
puts $txt "$s"
set  eps2C   -0.014006643
set s " lambda = 0.1" ;                               # ratio between unloading slope at $eps2 and initial slope $Ec
puts $txt "$s"
set  lambda  0.1

set s " epsc0 = 0.002801329"
puts $txt "$s"
set epsc0  0.002801329
set s "#tensile - Strength properties"
puts $txt "$s"
set s "ftC = 4.617798447e6" ;  # tensile strength (confined)   +tension
puts $txt "$s"
set ftC  4.617798447e6
set s  "ftU = 0.000224286"  ;  # tensile strength (unconfined) +tension
puts $txt "$s"
set ftU  0.000224286
set  epsc0  0.002801329
set s "Ets = $ftU/$epsc0"  ;  # tension softening stiffness
puts $txt "$s"
set Ets [expr $ftU/$epsc0]
#set up library of materials 

#*******************
#if { [info exists imat ] !=1} {set imat 0} ; # set value only if it has not been defined previously.
#*******************


set MatIDconcCoreB1  20000
set s "MatIDconcCoreB1 = 20000"
puts $txt "$s"

set uniaxialMaterial uniaxialMaterial

set s "$uniaxialMaterial ( 'Concrete02' , $MatIDconcCoreB1 , $fc1C , $eps1C , $fc2C , $eps2C , $lambda , $ftC , $Ets)" ;  # Core concrete (confined)
puts $txt "$s"

set s "#BEAM IN STORIES 1-20 B55x70"
puts $txt "$s"


set s "fc1C = -59.59e6" ;                     # CONFINED concrete (mander model), maximum stress
puts $txt "$s"
set fc1C  -59.59e6
set s "eps1C = -0.003879712" ;      # strain at maximum stress 
puts $txt "$s"
set eps1C  -0.003879712
set s "fc2C = -19.59e6"
puts $txt "$s"
set fc2C  -19.59e6
set s  "eps2C =  -0.019398558";		# strain at ultimate stress 
puts $txt "$s"
set eps2C   -0.019398558
set s "lambda = 0.1" ;                               # ratio between unloading slope at $eps2 and initial slope $Ec
puts $txt "$s"
set lambda  0.1
set s "epsc0 = 0.003879712"
set epsc0  0.003879712


set s "#tensile - Strength properties"
puts $txt "$s"
set s "ftC = 4.824659962e6" ;  # tensile strength (confined)   +tension
puts $txt "$s"
set ftC  4.824659962e6
set s "ftU = 0.000224286"  ;  # tensile strength (unconfined) +tension
puts $txt "$s"
set ftU  0.000224286
set s "Ets = $ftU/$epsc0"  ;  # tension softening stiffness
puts $txt "$s"
set Ets [expr $ftU/$epsc0]
#set up library of materials 

#*******************
#if { [info exists imat ] !=1} {set imat 0} ; # set value only if it has not been defined previously.
#*******************

set MatIDconcCoreB2 30000
set s "MatIDconcCoreB2 = 30000"
puts $txt "$s"
set uniaxialMaterial uniaxialMaterial
set s "$uniaxialMaterial ( 'Concrete02' , $MatIDconcCoreB2 , $fc1C , $eps1C , $fc2C , $eps2C , $lambda , $ftC , $Ets)" ;  # Core concrete (confined)
puts $txt "$s"

set s "#BEAM IN STORIES 21-30 B55x70"
puts $txt "$s"


set fc1C -58.07e6 ;                     # CONFINED concrete (mander model), maximum stress
set s "fc1C = -58.07e6"
puts $txt "$s"
set eps1C -0.003551909 ;      # strain at maximum stress
set s "eps1C = -0.003551909"
puts $txt "$s" 
set fc2C -18.07e6
set s "fc2C = -18.07e6"
puts $txt "$s" 
set eps2C  -0.017759547;		# strain at ultimate stress
set s "eps2C = -0.017759547"
puts $txt "$s" 
set lambda 0.1 ;                               # ratio between unloading slope at $eps2 and initial slope $Ec
set s "lambda = 0.1"
puts $txt "$s"
set epsc0 0.003551909
set s "epsc0 = 0.003551909"
puts $txt "$s"

set s "#tensile - Strength properties"
puts $txt "$s"
set ftC 4.762729653e6 ;  # tensile strength (confined)   +tension
set s "ftC = 4.762729653e6"
puts $txt "$s"
set ftU 0.000224286  ;  # tensile strength (unconfined) +tension
set s "ftU = 0.000224286"
puts $txt "$s"
set Ets [expr $ftU/$epsc0]  ;  # tension softening stiffness
set s "Ets = $ftU/$epsc0"
puts $txt "$s"
#set up library of materials 

#*******************
#if { [info exists imat ] !=1} {set imat 0} ; # set value only if it has not been defined previously.
#*******************

set MatIDconcCoreB3 40000
set s "MatIDconcCoreB3 = 40000"
puts $txt "$s"
set uniaxialMaterial uniaxialMaterial

set s "$uniaxialMaterial ( 'Concrete02' , $MatIDconcCoreB3 , $fc1C , $eps1C , $fc2C , $eps2C , $lambda , $ftC , $Ets)" ;  # Core concrete (confined)
puts $txt "$s"

set s "#UNCONFINED CONCRETE"
puts $txt "$s"


set fc1C $fc ;                     # CONFINED concrete (mander model), maximum stress
set s "fc1C = $fc"
puts $txt "$s"
set eps1C -0.002242857 ;      # strain at maximum stress 
set s "eps1C = -0.002242857"
puts $txt "$s"
set fc2C -12.e6
set s "fc2C = -12.e6"
puts $txt "$s"
set eps2C  -0.0036;		# strain at ultimate stress
set s "eps2C = -0.0036"
puts $txt "$s" 
set lambda 0.1 ;                               # ratio between unloading slope at $eps2 and initial slope $Ec
set s "lambda = 0.1"
puts $txt "$s" 
set epsc0 0.002242857
set s "epsc0 = 0.002242857"
puts $txt "$s" 


#tensile - Strength properties
set ftC 4.506939094e6 ;  # tensile strength (confined)   +tension
set s "ftC = 4.506939094e6"
puts $txt "$s"
set ftU 0.000224286  ;  # tensile strength (unconfined) +tension
set s "ftU = 0.000224286"
puts $txt "$s"
set Ets [expr $ftU/$epsc0]  ;  # tension softening stiffness
set s "Ets = $ftU/$epsc0"
puts $txt "$s"

#set up library of materials 

#*******************
#if { [info exists imat ] !=1} {set imat 0} ; # set value only if it has not been defined previously.
#*******************

set MatIDconcCoreB4 50000
set s "MatIDconcCoreB4 = 50000"
puts $txt "$s"
set uniaxialMaterial uniaxialMaterial

set s "$uniaxialMaterial ( 'Concrete02' , $MatIDconcCoreB4 , $fc1C , $eps1C , $fc2C , $eps2C , $lambda , $ftC , $Ets)" ;  # Cover concrete (unconfined)
puts $txt "$s"




################## REINFORCING STEEL parameters #########################
set Fy 491.5e6 ;   # STEEL yield stress (kg/m2)
set s "Fy = 491.5e6"
puts $txt "$s"
set Es 200.0e9;    # modulus of steel   (kg/m2)
set s "Es = 200.0e9"
puts $txt "$s"
set Bs 0.02 ;      # strain-hardening ratio 
set s "Bs = 0.02"
puts $txt "$s"
set R0 20 ;       # control the transition from elastic to plastic branches
set set "R0 = 20"
puts $txt "$s"
set cR1 0.925 ;    # control the transition from elastic to plastic branches
set s "cR1 = 0.925"
puts $txt "$s"
set cR2 0.15 ;     # control the transition from elastic to plastic branches
set s "cR2 = 0.15"
puts $txt "$s"

set MatIDSteel 60000
set s "MatIDSteel = 60000"
puts $txt "$s"
set uniaxialMaterial uniaxialMaterial
set s "uniaxialMaterial ( 'Steel02' , $MatIDSteel , $Fy , $Es , $Bs , $R0 , $cR1 , $cR2)"
puts $txt "$s"


proc BuildRCrectSection {SecTag BSec HSec cover coreID coverID steelID totalnumBars barDiameter numBarsTop numBarsBot nfCoreY nfCoreZ nfCoverY nfCoverZ} {
set s "def BuildRCrectSection (SecTag , BSec , HSec , cover , coreID , coverID , steelID , totalnumBars , barDiameter , numBarsTop , numBarsBot , nfCoreY , nfCoreZ , nfCoverY , nfCoverZ)" 
puts $txt "$s"
	################################################
	#BuildRCrectSection SecTag BSec HSec cover coreID coverID steelID totalnumBars barDiameter numBarsTop numBarsBot nfCoreY nfCoreZ nfCoverY nfCoverZ
	################################################
	# Build fiber rectangular RC section, 1 steel layer top, 1 bot, 1 skin, confined core
	# Define a procedure which generates a rectangular reinforced concrete section
	# with one layer of steel at the top & bottom, skin reinforcement and a 
	# confined core.
	#		by: Ali Naseri , 2013
	# 
	# Formal arguments
	#    SecTag - tag for the section that is generated by this procedure
	#    HSec - depth of section, along local-y axis
	#    BSec - width of section, along local-z axis
	#    cover - cover of section
	#    coreID - material tag for the core patch
	#    coverID - material tag for the cover patchttes
	#    steelID - material tag for the reinforcing steel
	#    totalnumBars - total number of reinforcing bars in section
	#    numBarsTop - number of reinforcing bars in the top layer
	#    numBarsBot - number of reinforcing bars in the bottom layer
	#    barDiameter - ghotre milgerd ha dar maghta
	#    nfCoreY - number of fibers in the core patch in the y direction
	#    nfCoreZ - number of fibers in the core patch in the z direction
	#    nfCoverY - number of fibers in the cover patches with long sides in the y direction
	#    nfCoverZ - number of fibers in the cover patches with long sides in the z direction
	#    
	#                        y
	#                        ^
	#                        |     
	#             ---------------------     --   --
	#             |   o     o     o   |     |    -- coverH
	#             |                   |     |
	#             |   o            o  |     |
	#    z <---   |         +         |     HSec
	#             |   o            o  |     |
	#             |                   |     |
	#             |   o  o  o  o o o  |     |    -- coverH
	#             ---------------------     --   --
	#             |--------Bsec-------|
	#             |----| coverB  |----|
	#
	#                       y
	#                       ^
	#                       |    
	#             ---------------------
	#             |\      cover      /|
	#             | \------Top------/ |
	#             |c|               |c|
	#             |o|               |o|
	#     z <-----|v|     core      |v|  HSec
	#             |e|               |e|
	#             |r|               |r|
	#             | /-------Bot------\|
	#             |/      cover      \|
	#             ---------------------
	#                       Bsec
	#    
	#
	# Notes
	#    The core concrete ends at the NA of the reinforcement
	#    The center of the section is at (0,0) in the local axis system
	# 
	set coverY [expr $HSec/2.0];		# The distance from the section z-axis to the edge of the cover concrete -- outer edge of cover concrete
      set s "coverY = $HSec/2.0"
      puts $txt "$s"
	set coverZ [expr $BSec/2.0];		# The distance from the section y-axis to the edge of the cover concrete -- outer edge of cover concrete
      set s "coverZ = $BSec/2.0"
      puts $txt "$s"
	set coreY  [expr $coverY-$cover];		# The distance from the section z-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concrete
      set s "coreY = $coverY-$cover"
      puts $txt "$s"
	set coreZ  [expr $coverZ-$cover];		# The distance from the section y-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concrete
      set s "coreZ = $coverZ-$cover"
      puts $txt "$s"
	set numBarsInt [expr $totalnumBars-($numBarsTop+$numBarsBot)/2];	# number of intermediate bars per side
      set s "numBarsInt = $totalnumBars-($numBarsTop+$numBarsBot)/2"
      puts $txt "$s"
#    numBarsInt - number of reinforcing bars on the intermediate layers,
	set barArea [expr 3.14*pow($barDiameter,2)/4]
      set s "barArea = 3.14*pow($barDiameter,2)/4"
      puts $txt "$s" 
	
	set DisBarL [expr ($HSec-2*$cover)/($numBarsInt+1)] ;   #DisbarL fasele 2 armator kenare ha az ham  ast
      set s "DisBarL = ($HSec-2*$cover)/($numBarsInt+1)"
      puts $txt "$s" 
	


	# Define the fiber section
	section fiberSec $SecTag {
		# Define the core patch
		patch quadr $coreID $nfCoreZ $nfCoreY -$coreY $coreZ -$coreY -$coreZ $coreY -$coreZ $coreY $coreZ
	   
		# Define the four cover patches
		patch quadr $coverID	 2	  $nfCoverY    -$coverY   $coverZ -$coreY   $coreZ   $coreY   $coreZ   $coverY  $coverZ
		patch quadr $coverID 	 2 	  $nfCoverY    -$coreY   -$coreZ  -$coverY -$coverZ  $coverY -$coverZ  $coreY  -$coreZ
		patch quadr $coverID $nfCoverZ      2 	   -$coverY   $coverZ -$coverY -$coverZ -$coreY  -$coreZ  -$coreY   $coreZ
		patch quadr $coverID $nfCoverZ 	2 	    $coreY    $coreZ   $coreY  -$coreZ   $coverY -$coverZ  $coverY  $coverZ	


		# define reinforcing layers
		layer straight $steelID $numBarsInt  $barArea  [expr (-$coreY+$DisBarL)]   $coreZ  [expr ($coreY-$DisBarL+0.01)]  $coreZ;	      # intermediate skin reinf. +z   
            #0.01 bekhater in ast ke armator haye janebi dar halati ke yek armator janebi vojod darad ebteda va entehaye "layer straight"  1cm fasle dashte bashad
		layer straight $steelID $numBarsInt  $barArea  [expr (-$coreY+$DisBarL)]  -$coreZ  [expr ($coreY-$DisBarL+0.01)]  -$coreZ;	      # intermediate skin reinf. -z
		layer straight $steelID $numBarsTop  $barArea           $coreY             $coreZ         $coreY                  -$coreZ;	      # top layer reinfocement
		layer straight $steelID $numBarsBot  $barArea          -$coreY             $coreZ        -$coreY                  -$coreZ;	      # bottom layer reinforcement

	};	# end of fibersection definition
};		# end of procedure



# define section tags:
#set ColSecAggTag 1
set BeamSecAggTag 1000
set GirdSecAggTag 101

#set ColSecTagFiber 1001
set BeamSecTagFiber 901
set GirdSecTagFiber 9001

set matTagTorsion 70
set Ubig 1.e10 ;            # a really large number




#**************** BEAM ****************
#BuildRCrectSection      SecTag          BSec     HSec   cover       MatCoreID        MatcoverID  MatsteelID  totalnumBars  barDiameter numBarsTop numBarsBot nfCoreY nfCoreZ nfCoverY nfCoverZ

#*** BEAM in story 1 to 10
#Left & Right
 BuildRCrectSection  $BeamSecTagFiber     0.40     0.60    0.04   $MatIDconcCoreB1        50000           60000           10          0.020        6          4         20      20       10       10
#center
# BuildRCrectSection      1001            0.45     0.35    0.05   $MatIDconcCoreB1        30           31            5          0.018        2          3         20      20       10       10


#*** BEAM in story 11 to 30
#Left & Right
 BuildRCrectSection       902           0.40     0.60    0.04   $MatIDconcCoreB1        50000           60000           12          0.020        7          5         20      20       10       10
#center
# BuildRCrectSection      2001           0.40     0.35    0.05   $MatIDconcCoreB2         30           31            5          0.018        2          3         20      20       10       10

#***Corner BEAM in story 1 to 20
#Left & Right
 BuildRCrectSection      903           0.55     0.70    0.04   $MatIDconcCoreB2        50000           60000           22          0.022        11          11         20      20       10       10
#center
# BuildRCrectSection      3001           0.35     0.35    0.05   $MatIDconcCoreB3         30           31            6          0.014        2          4         20      20       10       10

#***Corner BEAM in story 21 to 30
 BuildRCrectSection       904           0.55     0.70    0.04   $MatIDconcCoreB3         50000           60000           24          0.022        12          12         20      20       10       10
 
  
##**************** GIRD ****************
#Left & Right 1 to 10
 BuildRCrectSection  $GirdSecTagFiber     0.40     0.60    0.04   $MatIDconcCoreB1        50000           60000           19          0.020        10          9         20      20       10       10
#center
# BuildRCrectSection      1001            0.45     0.35    0.05   $MatIDconcCoreB1        30           31            5          0.018        2          3         20      20       10       10


#*** BEAM in story 11 to 30
#Left & Right
 BuildRCrectSection       9002           0.40     0.60    0.04   $MatIDconcCoreB1        50000           60000           20          0.020        10          10         20      20       10       10
#center
# BuildRCrectSection      2001           0.40     0.35    0.05   $MatIDconcCoreB2         30           31            5          0.018        2          3         20      20       10       10

#***Corner BEAM in story 1 to 20
#Left & Right
 BuildRCrectSection      9003           0.55     0.70    0.04   $MatIDconcCoreB2        50000           60000           30          0.022        15          15         20      20       10       10
#center
# BuildRCrectSection      3001           0.35     0.35    0.05   $MatIDconcCoreB3         30           31            6          0.014        2          4         20      20       10       10

#***Corner BEAM in story 21 to 30
 BuildRCrectSection       9004           0.55     0.70    0.04   $MatIDconcCoreB3         50000          60000           24          0.022        12          12         20      20       10       10
 



#%%%%%%%%%%%%%%%%%% assign torsional Stiffness for 3D Model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

#uniaxialMaterial Elastic      $matTag      $E    <$eta>
 uniaxialMaterial Elastic  $matTagTorsion   $Ubig


#***  beam story 
#Left & Right
section Aggregator  $BeamSecAggTag $matTagTorsion T -section $BeamSecTagFiber
#center
# section Aggregator      11        $matTagTorsion T -section        1001


#***  beam story 2
#Left & Right
 section Aggregator      2000         $matTagTorsion T -section       902
#center
# section Aggregator     21         $matTagTorsion T -section       2001


#***  beam story 3
#Left & Right
 section Aggregator      3000       $matTagTorsion T -section         903
#center
# section Aggregator     31        $matTagTorsion T -section        3001

#***  beam story 4
#Left & Right
 section Aggregator      4000        $matTagTorsion T -section        904

#***  Girder story 
#Left & Right
section Aggregator  $GirdSecAggTag $matTagTorsion T -section $GirdSecTagFiber
#center
# section Aggregator      11        $matTagTorsion T -section        1001


#***  beam story 2
#Left & Right
 section Aggregator      102         $matTagTorsion T -section       9002
#center
# section Aggregator     21         $matTagTorsion T -section       2001


#***  beam story 3
#Left & Right
 section Aggregator      103       $matTagTorsion T -section         9003
#center
# section Aggregator     31        $matTagTorsion T -section        3001

#***  beam story 4
#Left & Right
 section Aggregator      104        $matTagTorsion T -section        9004






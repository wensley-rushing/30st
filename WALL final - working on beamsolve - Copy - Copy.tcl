

#for {set mm 1} {$mm<=15} {incr mm 1} {

set mm 1
wipe
wipeAnalysis 
file mkdir data3d

file mkdir data/[expr $mm/10.]pga

set txt [open data3d/RCstory3D.py w+]
model basic -ndm 3 - ndf 6

#set s "model basic -ndm 3 - ndf 6"
#eval $s
#puts $txt "$s"

#set s "source WallSection334.tcl"
#eval $s
#puts $txt "$s"

    

# ------ frame configuration
set NStory 30.
set NBay   8   ; # in the first and end  of x dir
#set NBay2 6 ; # in the second and .. of x dir
set NBayM  7  ;# in the middle of x dir
set NBayZ  7
set NFrame [expr $NBayZ] ; # actually deal with frames in Z direction, as this is an easy extension of the 2d model

# define GEOMETRY -------------------------------------------------------------
# define structure-geometry paramters
set LCol 3.2 ;    # column height (parallel to Y axis)
set LColBase 4.5 ;    # column height in base
#set LBeam 5.  ;    # beam length (parallel to X axis)
#set LGird 5.  ;    # girder length (parallel to Z axis)
#set LBeam [list 0.  5.85  9.5  12.5   15.5   17    20.   23  24.5  27.5   30.5   34.15    40 ]  ;    # beam length (parallel to X axis)
set LBeam   [list 0.  6.0   9.5    15.5   20.    24.5   30.5    34.      40 ]  ;    # beam length (parallel to X axis)
#set LBeam2  [list 0.        9.5    15.5   20.    24.5   30.5             40 ]  ;    # beam length (parallel to X axis)
set LBeamM  [list 0.  5.75  12.5   17.    23.    27.5   34.25    40 ]  ;    # beam length (parallel to X axis)
set LGird   [list 0.  4.5  7.5  10.5   14.5   17.5  20.5  25]  ;    # girder length (parallel to Z axis)





set s "from openseespy.opensees import *"
puts $txt "$s"





#----------define mass center -----------
puts "#---------define center of mass nodes-----------"
set Xa 20.0  ;#center of mass in X dir
set Za 12.5  ;#center of mass in Y dir


###################################
#set iMasterNode ""
###################################

for {set level 1} {$level<=[expr $NStory]} {incr level 1} {

	  if {$level == 1 } {   ;#level in base storey






        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
     

# rigid-diaphragm nodes in center of each diaphram

set MasterNodeID [expr 9900+$level]


set massST1   1373610.98  
set massTY    1308015.37
set massLast  1146549.25

set mass $massTY

      if {$level == 1} {

set mass $massST1
}

      if {$level == $NStory} {
set mass $massLast
}



set s "node ( $MasterNodeID , $Xa , $Y , $Za , '-mass' , $mass , 1.e-6 , $mass , 1.e-6 , 1.e-6 , 1.e-6)"
#eval $s
puts $txt "$s"

set s "fix ( $MasterNodeID , 0 , 1 , 0 , 1 , 0 , 1)"
#eval $s
puts $txt "$s"

       }

#-------------------------------------





#
#
##rigid diaphragm nodes
#puts $txt "#rigid diaphragm nodes"
#set RigidDiaphragm ON ;        # options: ON, OFF. specify this before the analysi
#
####################################
#lappend iMasterNode $MasterNodeID
####################################
#
set perpDirn 2
#for {set frame 0} {$frame<=[expr $NBayZ]} {incr frame 1 } {
#for {set pier 0} {$pier<=[expr $NBay]} {incr pier 1} {
##set nodeID [expr ($level*$Dlevel+$frame*$Dframe+$pier+9900)]
##
#set s "rigidDiaphragm $perpDirn $MasterNodeID $nodeID";
##eval $s
#puts $txt "$s"
#    			} 
#        	}
#
#





#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p19 and p22 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#-------shear wall node------------ "
puts $txt "$s"

set LPY19  [list  0. 7.5   17.5]  ;    # beam length (parallel to X axis)
set LPX19  [list  0.  6.0]  ;    # beam length (parallel to X axis)


#define Nodal coordinates
set Dlevel 1000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 100;	      # numbering increment for new-frame nodes

set Dpier  7

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1} {   ;#level in base storey
#        set    LCol $LColBase



        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 1} {$frame<=2} {incr frame 1 } {
set Z [lindex $LPY19 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

  

            set X [lindex $LPX19 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
        if {$level >=1 } {
	
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  }
                            
  }  
    } 
      





#define element of shear wall - p19 and p22

set N1Story 15  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<= [expr $N1Story-1]} {incr level 1} {
for {set frame 1} {$frame<= 2} {incr frame 1 } {
for {set pier 0} {$pier<= 0 } {incr pier 1} {


               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, *eleNodes, m, '-thick', *thick, '-width', *widths, '-rho', *rho, '-matConcrete', *matConcreteTags, '-matSteel', *matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)

set width1 1.6
set width2 1.4
set rho1 0.011126474
set rho2 0.002056995
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 301
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
puts $txt "$s"

 }
   }
     } 
            
                           
                             



;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 1} {$frame <= 2} {incr frame 1 } {
for {set pier 0} {$pier <= 0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.001178097
set rho2 0.001178097
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}
                   

				


#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p20 and p21 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LPY20  [list  0. 10.5   14.5]  ;    # beam length (parallel to X axis)
set LPX20  [list  0.  6.0]  ;    # beam length (parallel to X axis)


#define Nodal coordinates
set Dlevel 100000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 1000;	      # numbering increment for new-frame nodes

set Dpier  13

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase


     #


        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 1} {$frame<=2} {incr frame 1 } {
set Z [lindex $LPY20 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

  

            set X [lindex $LPX20 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"  
 

      if {$level>=1 } {
	 set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
      


                       
  }  
    } 
      }





#define element of shear wall - p20 and p21

set N1Story 13  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 1} {$frame<=2} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.6
set width2 1.4
set rho1 0.011126474
set rho2 0.002056995
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 301
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 1} {$frame <=2} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.001178097
set rho2 0.001178097
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}


#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p2 and p1 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LPY2  [list  0. 0.   25.]  ;    # beam length (parallel to X axis)
set LPX2  [list  0.  6.0]  ;    # beam length (parallel to X axis)


#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 1000;	      # numbering increment for new-frame nodes

set Dpier  25

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 1} {$frame<=2} {incr frame 1 } {
set Z [lindex $LPY2 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

  

            set X [lindex $LPX2 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"  
          
      if {$level>=1 } {
	  
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                  
  }  
    } 
      }






#define element of shear wall - p2 and p1

set N1Story 8  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 1} {$frame<=2} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {


 
               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.5
set width2 1.5
set rho1 0.004016241
set rho2 0.004016241
set thickness 0.55
set UcmatConcrete 3
set CmatConcrete 3
set matSteel 400
set matShear 302
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             


;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 1} {$frame <=2} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.019039955
set rho2 0.002855993
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 4
set matSteel 400
set matShear 303



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}




#%%%%%%%%%%%%%%%%%%%%% Shear wall Node P5 and p9 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LxP5  [list  9.5  30.5 ]  ;    # beam length (parallel to X axis)
set LyP5  [list 0.   5.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 1000;	      # numbering increment for new-frame nodes

set Dpier  47

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1  } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP5 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LxP5 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
      
      if {$level>=1 } {
	  
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  

                      
  }  
    } 
      }








#define element of shear wall - P5 and p9

set N1Story 12  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 0} {$pier<=1 } {incr pier 1} {


 
               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.5
set width2 1
set rho1 0.002627514
set rho2 0.002627514
set thickness 0.55
set UcmatConcrete 5
set CmatConcrete 5
set matSteel 400
set matShear 304
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 0} {$pier <=1 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1
set rho1 0.012185572
set rho2 0.002855993
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 4
set matSteel 400
set matShear 303



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}




#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p6 and p8 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LxP6  [list  15.5    24.5 ]  ;    # beam length (parallel to X axis)
set LyP6  [list 0.   5.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 1000;	      # numbering increment for new-frame nodes

set Dpier  45

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1  } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP6 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LxP6 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
     
      if {$level>=1 } {
	
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                       
  }  
    } 
      }




#define element of shear wall - p6 and p8

set N1Story 15  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 0} {$pier<=1 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1.5
set rho1 0.002627514
set rho2 0.002627514
set thickness 0.55
set UcmatConcrete 5
set CmatConcrete 5
set matSteel 400
set matShear 304
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 0} {$pier <=1 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]



               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1.5
set rho1 0.013708768
set rho2 0.002284795
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 6
set matSteel 400
set matShear 305



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}




#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p7 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LxP7  [list    20   ]  ;    # beam length (parallel to X axis)
set LyP7  [list 0.   5.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 1000;	      # numbering increment for new-frame nodes

set Dpier  53

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP7 $frame];
for {set pier 0} {$pier<=0} {incr pier 1} {

            set X [lindex $LxP7 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
        
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                    
  }  
    } 
      }








#define element of shear wall - p7

set N1Story 12  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1
set rho1 0.005711987
set rho2 0.003655671
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 7
set matSteel 400
set matShear 306
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 5 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,$thickness,'-width',  $width1,	$width2, $width2, $width2, $width1,'-rho', $rho1,    $rho1,	 $rho2, $rho1,  $rho1,	'-matConcrete',	$CmatConcrete, $CmatConcrete , $UcmatConcrete , $CmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel, $matSteel, '-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1
set rho1 0.006854384
set rho2 0.000974846
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 6
set matSteel 400
set matShear 305



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 5 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,$thickness,'-width',  $width1,	$width2, $width2, $width2, $width1,'-rho', $rho1,    $rho2,	 $rho2, $rho2,  $rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel, $matSteel, '-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}



#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p38 and p40 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LxP38  [list  0.    40. ]  ;    # beam length (parallel to X axis)
set LyP38  [list 0.  4.5]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 1000;	      # numbering increment for new-frame nodes

set Dpier  63

for {set level 0 } {$level<= $NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase
        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP38 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LxP38 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
       
      if {$level>=1 } {
	  
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                     
  }  
    } 
      }






#define element of shear wall - p38 and p40


set N1Story 11  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 0} {$pier<=1 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.5
set width2 1.5
set rho1 0.007174983
set rho2 0.007174983
set thickness 0.55
set UcmatConcrete 8
set CmatConcrete 8
set matSteel 400
set matShear 306
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 0} {$pier <=1 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.012185572
set rho2 0.00170598
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 4
set matSteel 400
set matShear 303



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}







#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p23 and p26 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LPy23  [list  7.5    17.5 ]  ;    # beam length (parallel to X axis)
set LPx23  [list 34.   40.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 100000;	      # numbering increment for new-frame nodes

set Dpier  65

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LPy23 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LPx23 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
           
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                 
  }  
    } 
      }







#define element of shear wall - p23 and p26

set N1Story 15  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=1} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.6
set width2 1.4
set rho1 0.011126474
set rho2 0.002056995
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 301
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
            
}
}
}                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=1} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.001178097
set rho2 0.001178097
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}




#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p3 and p4 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LPy3  [list  0.    25. ]  ;    # beam length (parallel to X axis)
set LPx3  [list 34.   40.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 100000;	      # numbering increment for new-frame nodes

set Dpier  83

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LPy3 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LPx3 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
       
      if {$level>=1 } {
	
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                     
  }  
    } 
      }





#define element of shear wall - p3 and p4

set N1Story 8  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=1} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {


 
               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.5
set width2 1.5
set rho1 0.004016241
set rho2 0.004016241
set thickness 0.55
set UcmatConcrete 3
set CmatConcrete 3
set matSteel 400
set matShear 302
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=1} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.019039955
set rho2 0.002855993
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 4
set matSteel 400
set matShear 303



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}


#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p24 and p25 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LPy24  [list  10.5    14.5 ]  ;    # beam length (parallel to X axis)
set LPx24  [list 34.  40.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes
#NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
set Dframe 100000;	      # numbering increment for new-frame nodes

set Dpier  73

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LPy24 $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LPx24 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
         
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                   
  }  
    } 
      }







#define element of shear wall - p24 and p25

set N1Story 13  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=1} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {


 
               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.6
set width2 1.4
set rho1 0.011126474
set rho2 0.002056995
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 301
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
            
}
}
}                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=1} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.001178097
set rho2 0.001178097
set thickness 0.6
set UcmatConcrete 1
set CmatConcrete 2
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}


#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p10 and p14 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p6 "
puts $txt "$s"

set LxP10  [list 0.  9.5   30.5]  ;    # beam length (parallel to X axis)
set LyP10  [list    20.     25.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  10


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP10 $frame];
for {set pier 1} {$pier<=2} {incr pier 1} {

            set X [lindex $LxP10 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
        
      if {$level>=1 } {
	  
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                    
  }  
    } 
      }








#define element of shear wall - p10 and p14

set N1Story 12  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=2 } {incr pier 1} {


 
               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.5
set width2 1
set rho1 0.002627514
set rho2 0.002627514
set thickness 0.55
set UcmatConcrete 5
set CmatConcrete 5
set matSteel 400
set matShear 304
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             



;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]



               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1
set rho1 0.012185572
set rho2 0.002855993
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 4
set matSteel 400
set matShear 303



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}




#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p11 and p13 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p6 "
puts $txt "$s"

set LxP11  [list 0.  15.5   24.5]  ;    # beam length (parallel to X axis)
set LyP11  [list    20.    25.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  88


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP11 $frame];
for {set pier 1} {$pier<=2} {incr pier 1} {

            set X [lindex $LxP11 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
       
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                     
  }  
    } 
      }





#define element of shear wall - p11 and p13

set N1Story 15  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=2 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1.5
set rho1 0.002627514
set rho2 0.002627514
set thickness 0.55
set UcmatConcrete 5
set CmatConcrete 5
set matSteel 400
set matShear 304
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             


;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=2 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1.5
set rho1 0.013708768
set rho2 0.002284795
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 6
set matSteel 400
set matShear 305



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 4 ,'-thick' , $thickness ,$thickness ,$thickness ,$thickness,'-width',  $width1,	$width2, $width2,	$width1,'-rho',	$rho1,    $rho2,	$rho2,	$rho1,	'-matConcrete',	$UcmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete ,'-matSteel',$matSteel,	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}



#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p12 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p6 "
puts $txt "$s"

set LxP12  [list 0.  20.]  ;    # beam length (parallel to X axis)
set LyP12  [list    20.   25.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  92


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP12 $frame];
for {set pier 1} {$pier<=1} {incr pier 1} {

            set X [lindex $LxP12 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
       
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                     
  }  
    } 
      }




#define element of shear wall - p12

set N1Story 12  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=1 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1
set rho1 0.005711987
set rho2 0.003655671
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 7
set matSteel 400
set matShear 306
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 5 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,$thickness,'-width',  $width1,	$width2, $width2, $width2, $width1,'-rho', $rho1,    $rho1,	 $rho2, $rho1,  $rho1,	'-matConcrete',	$CmatConcrete, $CmatConcrete , $UcmatConcrete , $CmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel, $matSteel, '-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=1 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1
set rho1 0.006854384
set rho2 0.000974846
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 6
set matSteel 400
set matShear 305



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 5 ,	'-thick' , $thickness ,$thickness ,$thickness ,$thickness,$thickness,'-width',  $width1,	$width2, $width2, $width2, $width1,'-rho', $rho1,    $rho2,	 $rho2, $rho2,  $rho1,	'-matConcrete',	$CmatConcrete, $UcmatConcrete , $UcmatConcrete , $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,	$matSteel, $matSteel, '-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}


#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p37 and p39 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p6 "
puts $txt "$s"

set LxP37  [list 0.  0.  40.]  ;    # beam length (parallel to X axis)
set LyP37  [list    20.5     25.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  98


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP37 $frame];
for {set pier 1} {$pier<=2} {incr pier 1} {

            set X [lindex $LxP37 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
          
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                  
  }  
    } 
      }






#define element of shear wall - p37 and p39

set N1Story 11  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1.5
set width2 1.5
set rho1 0.007174983
set rho2 0.007174983
set thickness 0.55
set UcmatConcrete 8
set CmatConcrete 8
set matSteel 400
set matShear 306
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1.5
set width2 1.5
set rho1 0.012185572
set rho2 0.00170598
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 4
set matSteel 400
set matShear 303



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}





##%%%%%%%%%%%%%%%%%%%%% Shear wall Node p28 and p30 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p28&30 "
puts $txt "$s"

set LxP28  [list    0.   12.5   27.5]  ;    # beam length (parallel to X axis)
set LyP28  [list    7.5    10.5]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  100


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP28 $frame];
for {set pier 1} {$pier<=2} {incr pier 1} {

            set X [lindex $LxP28 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
        
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                    
  }  
    } 
      }





#define element of shear wall - p28 and p30

set N1Story 13  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=2 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1
set rho1 0.003681058
set rho2 0.003681058
set thickness 0.55
set UcmatConcrete 9
set CmatConcrete 9
set matSteel 400
set matShear 307
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1
set rho1 0.002284795
set rho2 0.002284795
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 1
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}



#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p34 and p36 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p15 "
puts $txt "$s"

set LxP34  [list    0.   17.   23.]  ;    # beam length (parallel to X axis)
set LyP34  [list    7.5    10.5]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  103


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase
        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP34 $frame];
for {set pier 1} {$pier<=2} {incr pier 1} {

            set X [lindex $LxP34 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
        
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                    
  }  
    } 
      }





#define element of shear wall - p34 and p36

set N1Story 11  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=2 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1
set rho1 0.009081558
set rho2 0.009081558
set thickness 0.55
set UcmatConcrete 9
set CmatConcrete 9
set matSteel 400
set matShear 308
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1
set rho1 0.003006309
set rho2 0.003006309
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 1
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}



#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p27 and p29 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p16 "
puts $txt "$s"

set LxP27  [list    0.   12.5   27.5]  ;    # beam length (parallel to X axis)
set LyP27  [list    14.5    17.5 ]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  600


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP27 $frame];
for {set pier 1} {$pier<=2} {incr pier 1} {

            set X [lindex $LxP27 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
       
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                     
  }  
    } 
      }







#define element of shear wall - p27 and p29

set N1Story 13  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1
set rho1 0.003681058
set rho2 0.003681058
set thickness 0.55
set UcmatConcrete 9
set CmatConcrete 9
set matSteel 400
set matShear 307
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1
set rho1 0.002284795
set rho2 0.002284795
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 1
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}

#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p32 and p33 %%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node p16 "
puts $txt "$s"

set LxP32  [list    0.   17.  23.]  ;    # beam length (parallel to X axis)
set LyP32  [list    14.5    17.5 ]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  604


for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1} {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 0} {$frame<=1} {incr frame 1 } {
set Z [lindex $LyP32 $frame];
for {set pier 1} {$pier<=2} {incr pier 1} {

            set X [lindex $LxP32 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
        
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                    
  }  
    } 
      }






#define element of shear wall - p32 and p33

set N1Story 11  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 0} {$frame<=0} {incr frame 1 } {
for {set pier 1} {$pier<=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 1
set width2 1
set rho1 0.009081558
set rho2 0.009081558
set thickness 0.55
set UcmatConcrete 9
set CmatConcrete 9
set matSteel 400
set matShear 308
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 0} {$frame <=0} {incr frame 1 } {
for {set pier 1} {$pier <=2 } {incr pier 1} {



              set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+($frame+1)*$Dframe+$pier+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]




               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 1
set width2 1
set rho1 0.003006309
set rho2 0.003006309
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 1
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}




#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p31%%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LP31   [list   17.   23.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  1000

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1} {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 2} {$frame<=2} {incr frame 1 } {
set Z [lindex $LGird $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LP31 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
         
      if {$level>=1 } {
	 
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  
                   
  }  
    } 
      }





#define element of shear wall - P31

set N1Story 12  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 2} {$frame<=2} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 2
set width2 2
set rho1 0.002685799
set rho2 0.002685799
set thickness 0.55
set UcmatConcrete 5
set CmatConcrete 5
set matSteel 400
set matShear 304
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 2} {$frame <=2} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 2
set width2 2
set rho1 0.001392637
set rho2 0.001392637
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 1
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}



#%%%%%%%%%%%%%%%%%%%%% Shear wall Node p35%%%%%%%%%%%%%%%%%%%%%%%%%
set s "#shear wall node "
puts $txt "$s"

set LP35   [list   17.  23.]  ;    # beam length (parallel to X axis)

#define Nodal coordinates
set Dlevel 1000000 ;	# numbering increment for new-level nodes

set Dframe 100000;	      # numbering increment for new-frame nodes


set Dpier  1000

for {set level 0 } {$level<=$NStory} {incr level 1} {
	  if {$level == 0 || $level == 1 } {   ;#level in base storey
#        set    LCol $LColBase

        set Y [expr ($level)*($LColBase)];
      } else { 
       set Delta [expr $LColBase-$LCol]
        set Y [expr ($level)*($LCol)+$Delta];
         }
for {set frame 5} {$frame<=5} {incr frame 1 } {
set Z [lindex $LGird $frame];
for {set pier 0} {$pier<=1} {incr pier 1} {

            set X [lindex $LP35 $pier];
            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]

            set s "node ( $nodeID , $X , $Y , $Z)"
#            eval $s
            puts $txt "$s"
         
      if {$level>=1 } {
	  
set MasterNodeID [expr 9900+$level]
set s "rigidDiaphragm ( $perpDirn , $MasterNodeID , $nodeID)";
#eval $s
puts $txt "$s"

}
  


                   
  }  
    } 
      }





#define element of shear wall - p35

set N1Story 12  ;# first part of the section shear wall 
# 
for {set level 0 } {$level<=[expr $N1Story-1]} {incr level 1} {
for {set frame 5} {$frame<=5} {incr frame 1 } {
for {set pier 0} {$pier<=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 




               
            
#element('MVLEM_3D', eleTag, eleNodes, m, '-thick', thick, '-width', widths, '-rho', rho, '-matConcrete', matConcreteTags, '-matSteel', matSteelTags, '-matShear', matShearTag, <'-CoR', c>, <'-ThickMod', tMod>, <'-Poisson', Nu>, <'-Density', Dens>)
set width1 2
set width2 2
set rho1 0.002685799
set rho2 0.002685799
set thickness 0.55
set UcmatConcrete 5
set CmatConcrete 5
set matSteel 400
set matShear 304
set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"
#        eval $s
               puts $txt "$s"

  
}
}
}            
                           
                             




;# second part of the section shear wall
for {set level [expr $N1Story]} {$level <= [expr $NStory-1]} {incr level 1} {
for {set frame 5} {$frame <=5} {incr frame 1 } {
for {set pier 0} {$pier <=0 } {incr pier 1} {



               set iNode [expr  $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
               set jNode [expr  $level*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set kNode [expr ($level+1)*$Dlevel+$frame*$Dframe+($pier+1)+$Dpier]
               set lNode [expr ($level+1)*$Dlevel+$frame*$Dframe+$pier+$Dpier]


               set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier] 

set width1 2
set width2 2
set rho1 0.001392637
set rho2 0.001392637
set thickness 0.55
set UcmatConcrete 1
set CmatConcrete 1
set matSteel 400
set matShear 300



set s "element ('MVLEM_3D', $eleTag , $iNode , $jNode , $kNode , $lNode , 3 ,	'-thick' , $thickness ,$thickness ,$thickness ,'-width',  $width1,	$width2,  $width1,'-rho',	$rho1,    $rho2,	$rho1, '-matConcrete',	$CmatConcrete, $UcmatConcrete , $CmatConcrete ,'-matSteel',	$matSteel,	$matSteel,	$matSteel,'-matShear',$matShear)"


puts $txt "$s"  
            

  }
         }
			}


set s "fixY ( 0.0 , 1 , 1 , 1 , 1 , 1 , 1)"
puts $txt "$s"







#------------------define geomTransf------------

#set s "geomTransf (  'Corotational'   ,  2    ,  0  , 0  , 1)" ;# all beams
#puts $txt "$s"
#
#set s "geomTransf (  'Corotational'   ,  3   ,  -1  , 0  , 0)" ;# all girds
#puts $txt "$s" 
#
set s "geomTransf (  'Linear'   ,  2    ,  0  , 0  , 1)" ;# all beams
puts $txt "$s"

set s "geomTransf (  'Linear'   ,  3    ,  -1  , 0  , 0)" ;# all girds
puts $txt "$s"




set s "#++++++++++++++++++++++++++++ create bottom beams ++++++++++++++++++++++++++++++"
puts $txt "$s"
set s "#p1-p5"
puts $txt "$s"
for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   25

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  1000
set jDpier   47

set jframep1 0
set jpierp1 0

set beam 100

 set numIntgrPts 3

set  sec4B40x60 3000 ;#  section beam fro 1 to 10
set  sec5B40x60 4000 ;#  section beam fro 11 to 30
#set  sec6B40x60 4 ;#  section beam fro 21 to 30


set secTag  $sec5B40x60

if {$level<=[expr 10*3]} {
set secTag $sec4B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec5B40x60
} 





set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,   2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p5-p6"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   47

set iframep1 0
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   45

set jframep1 0
set jpierp1 0

set beam 200


   set numIntgrPts 3

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
}






set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p6-p7"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   45

set iframep1 0
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   53

set jframep1 0
set jpierp1 0

set beam 300


   set numIntgrPts 5

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
}






set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,   2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p7-p8"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   53

set iframep1 0
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   45

set jframep1 0
set jpierp1 1

set beam 400


   set numIntgrPts 3

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
}






set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,  2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p8-p9"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   45

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  1000
set jDpier   47

set jframep1 0
set jpierp1 1

set beam 500


   set numIntgrPts 3

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
}






set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p9-p3"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   47

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   83

set jframep1 0
set jpierp1 0

set beam 600


 set numIntgrPts 3

set  sec4B40x60 3000 ;#  section beam fro 1 to 10
set  sec5B40x60 4000 ;#  section beam fro 11 to 30
#set  sec6B40x60 4 ;#  section beam fro 21 to 30


set secTag  $sec5B40x60

if {$level<=[expr 10*3]} {
set secTag $sec4B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec5B40x60
} 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,  2,'-iter',50,1e-2) "

            puts $txt "$s"


			}


set s "#----------------------------Top beams------------------------------------"
puts $txt "$s"


set s "#p2-p10"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   25

set iframep1 2
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   10

set jframep1 1
set jpierp1 1

set beam 700


 set numIntgrPts 3

set  sec4B40x60 3000 ;#  section beam fro 1 to 10
set  sec5B40x60 4000 ;#  section beam fro 11 to 30
#set  sec6B40x60 4 ;#  section beam fro 21 to 30


set secTag  $sec5B40x60

if {$level<=[expr 10*3]} {
set secTag $sec4B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec5B40x60
} 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 2,'-iter',50,1e-2) "

            puts $txt "$s"


			}


set s "#p10-p11"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   10

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   88

set jframep1 1
set jpierp1 1

set beam 800


   set numIntgrPts 3

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
} 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p11-p12"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   88

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   92

set jframep1 1
set jpierp1 1

set beam 900


   set numIntgrPts 3

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
} 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p12-p13"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   92

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   88

set jframep1 1
set jpierp1 2

set beam 1000


   set numIntgrPts 3

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
} 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,  2,'-iter',50,1e-2) "

            puts $txt "$s"


			}



set s "#p13-p14"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   88

set iframep1 1
set ipierp1 2


set jDlevel 1000000
set jDframe  100000
set jDpier   10

set jframep1 1
set jpierp1 2

set beam 1200


   set numIntgrPts 3

set  sec1B40x60 1000 ;# section beam fro 1 to 10
set  sec2B40x60 2000 ;# section beam fro 11 to 30
#set  sec3B40x60 3 ;# section beam fro 21 to 30

set secTag  $sec2B40x60

if {$level<=[expr 10*3]} {
set secTag $sec1B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2B40x60
} 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,  2,'-iter',50,1e-2) "

            puts $txt "$s"


			}

set s "#p14-p4"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   10

set iframep1 1
set ipierp1 2


set jDlevel 1000000
set jDframe  100000
set jDpier   83

set jframep1 1
set jpierp1 0

set beam 1300


  set numIntgrPts 3

set  sec4B40x60 3000 ;#  section beam fro 1 to 10
set  sec5B40x60 4000 ;#  section beam fro 11 to 30
#set  sec6B40x60 4 ;#  section beam fro 21 to 30


set secTag  $sec5B40x60

if {$level<=[expr 10*3]} {
set secTag $sec4B40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec5B40x60
} 
 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,  2,'-iter',50,1e-2) "

            puts $txt "$s"


			}


set s "#----------------left girder------------------------"
puts $txt "$s"


set s "#p37-p22"
puts $txt "$s"

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   98

set iframep1 0
set ipierp1 1


set jDlevel 1000
set jDframe  100
set jDpier   7

set jframep1 2
set jpierp1 0

set beam 1400


 set numIntgrPts 3

set  sec4G55x70 103 ;#  section Girder from 1 to 20
#set  sec5G55x70 5 ;#  section Girder from 11 to 20
set  sec6G55x70 104 ;#  section Girder from 21 to 30


set secTag  $sec4G55x70

if {$level<=[expr 10*3]} {
set secTag $sec4G55x70
}
if {$level>=[expr 21*3]} {
set secTag $sec6G55x70
} 

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}


#p22-p21

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000
set iDframe  100
set iDpier   7

set iframep1 2
set ipierp1 0


set jDlevel 100000
set jDframe  1000
set jDpier   13

set jframep1 2
set jpierp1 0

set beam 1500


set numIntgrPts 3


set  sec1G40x60 101 ;# section Girder from 1 to 10
set  sec2G40x60 102 ;# section Girder from 11 to 20
#set  sec3G40x60 102 ;# section Girder from 21 to 30

set secTag  $sec2G40x60

if {$level<=[expr 10*3]} {
set secTag $sec1G40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2G40x60
}

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}

#p21-p20

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 100000
set iDframe  1000
set iDpier   13

set iframep1 2
set ipierp1 0


set jDlevel 100000
set jDframe  1000
set jDpier   13

set jframep1 1
set jpierp1 0

set beam 1600


set numIntgrPts 3


set  sec1G40x60 101 ;# section Girder from 1 to 10
set  sec2G40x60 102 ;# section Girder from 11 to 20
#set  sec3G40x60 102 ;# section Girder from 21 to 30

set secTag  $sec2G40x60

if {$level<=[expr 10*3]} {
set secTag $sec1G40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2G40x60
}

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag ,   3,'-iter',50,1e-2) "

            puts $txt "$s"


			}


#p20-p19

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 100000
set iDframe  1000
set iDpier   13

set iframep1 1
set ipierp1 0


set jDlevel 1000
set jDframe  100
set jDpier   7

set jframep1 1
set jpierp1 0

set beam 1700


set numIntgrPts 3


set  sec1G40x60 101 ;# section Girder from 1 to 10
set  sec2G40x60 102 ;# section Girder from 11 to 20
#set  sec3G40x60 102 ;# section Girder from 21 to 30

set secTag  $sec2G40x60

if {$level<=[expr 10*3]} {
set secTag $sec1G40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2G40x60
}

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}


#p19-p38

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000
set iDframe  100
set iDpier   7

set iframep1 1
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   63

set jframep1 1
set jpierp1 0

set beam 1800


set numIntgrPts 3

set  sec4G55x70 103 ;#  section Girder from 1 to 20
#set  sec5G55x70 5 ;#  section Girder from 11 to 20
set  sec6G55x70 104 ;#  section Girder from 21 to 30


set secTag  $sec4G55x70

if {$level<=[expr 10*3]} {
set secTag $sec4G55x70
}
if {$level>=[expr 21*3]} {
set secTag $sec6G55x70
} 

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}


#--------------------right gird------------------------


#p39-p26

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   98

set iframep1 0
set ipierp1 2


set jDlevel 1000000
set jDframe  100000
set jDpier   65

set jframep1 1
set jpierp1 1

set beam 1900


set numIntgrPts 3

set  sec4G55x70 103 ;#  section Girder from 1 to 20
#set  sec5G55x70 5 ;#  section Girder from 11 to 20
set  sec6G55x70 104 ;#  section Girder from 21 to 30


set secTag  $sec4G55x70

if {$level<=[expr 10*3]} {
set secTag $sec4G55x70
}
if {$level>=[expr 21*3]} {
set secTag $sec6G55x70
} 

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}

#p26-p25

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   65

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   73

set jframep1 1
set jpierp1 1

set beam 2000


set numIntgrPts 3


set  sec1G40x60 101 ;# section Girder from 1 to 10
set  sec2G40x60 102 ;# section Girder from 11 to 20
#set  sec3G40x60 102 ;# section Girder from 21 to 30

set secTag  $sec2G40x60

if {$level<=[expr 10*3]} {
set secTag $sec1G40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2G40x60
}

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}

#p25-p24

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   73

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   73

set jframep1 0
set jpierp1 1

set beam 2100


set numIntgrPts 3


set  sec1G40x60 101 ;# section Girder from 1 to 10
set  sec2G40x60 102 ;# section Girder from 11 to 20
#set  sec3G40x60 102 ;# section Girder from 21 to 30

set secTag  $sec2G40x60

if {$level<=[expr 10*3]} {
set secTag $sec1G40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2G40x60
}

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}

#p24-p23

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   73

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   65

set jframep1 0
set jpierp1 1

set beam 2200


set numIntgrPts 3


set  sec1G40x60 101 ;# section Girder from 1 to 10
set  sec2G40x60 102 ;# section Girder from 11 to 20
#set  sec3G40x60 102 ;# section Girder from 21 to 30

set secTag  $sec2G40x60

if {$level<=[expr 10*3]} {
set secTag $sec1G40x60
}
if {$level>=[expr 21*3]} {
set secTag $sec2G40x60
}

 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}

#p23-p40

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   65

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  1000
set jDpier   63

set jframep1 1
set jpierp1 1

set beam 2300


set numIntgrPts 3

set  sec4G55x70 103 ;#  section Girder from 1 to 20
#set  sec5G55x70 5 ;#  section Girder from 11 to 20
set  sec6G55x70 104 ;#  section Girder from 21 to 30


set secTag  $sec4G55x70

if {$level<=[expr 10*3]} {
set secTag $sec4G55x70
}
if {$level>=[expr 21*3]} {
set secTag $sec6G55x70
} 


 







set inodeID [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier)]
set jnodeID [expr ($level*$jDlevel+$jframep1*$jDframe+$jpierp1+$jDpier)]

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]


set s "element ( 'nonlinearBeamColumn' , $eleTag , $inodeID , $jnodeID , $numIntgrPts , $secTag  , 3,'-iter',50,1e-2) "

            puts $txt "$s"


			}



set s "#--------------define beam loading--------------"
puts $txt "$s"
 
set s "timeSeries('Linear', 1) "
            puts $txt "$s" 

set s "pattern('Plain', 1, 1) "
            puts $txt "$s" 
#
##NOTE: unit N
#
#set Dlevel 10000000 ;	# numbering increment for new-level nodes
##NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
#set Dframe 100000;	      # numbering increment for new-frame nodes
#
#set Dpier  1000
#
#
#for {set level 3 } {$level<=[expr $NStory*3.]} {incr level 3} {
#for {set frame 0} {$frame<=7} {incr frame 7 } {
#for {set pier 1} {$pier<=6} {incr pier 1} {
#
##            set nodeID [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
#
#            
#      
#
#                  
#            set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
#set beamuniform -4.526e3   ;# minus mwans opposite of Y direction
#
#   set s "eleLoad -ele $eleTag -type  -beamUniform  $beamuniform   0." ;    # BEAMS - unit N
#         
##            eval $s
#            puts $txt "$s"  
#                            
#  }  
#    } 
#      }
#
#
#
#
#set s "#--------------define girder loading--------------"
#puts $txt "$s"
#
##set Dlevel 10000000 ;	# numbering increment for new-level nodes
###NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
##set Dframe 100000;	      # numbering increment for new-frame nodes
##
##set Dpier  65000
##
##set LGird40x60   [list     7.5  10.5   14.5   17.5   ]
#
##define Nodal coordinates
#set Dlevel 10000000 ;	# numbering increment for new-level nodes
##NOTE : IF Number of Frame is more than 9 you shoud (set Dlevel 10000)
#set Dframe 100000;	      # numbering increment for new-frame nodes
#
#set Dpier  10000
#
#
#for {set level 3 } {$level<=[expr $NStory*3.]} {incr level 3} {
#for {set pier 0} {$pier<=8} {incr pier 8} {
#for {set frame 1} {$frame<=5} {incr frame 1 } {
#
#
#     
#            
#             set eleTag [expr $level*$Dlevel+$frame*$Dframe+$pier+$Dpier]
#set beamuniform -4.526e3   ;# minus mwans opposite of Y direction
#
#   set s "eleLoad -ele $eleTag -type  -beamUniform  $beamuniform   0." ;    # BEAMS - unit N
#         
##            eval $s
#            puts $txt "$s"  
#                           
#  }  
#    } 
#      }
#
#set s " } "
#            puts $txt "$s"
#
#
#

#p1-p5

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   25

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  1000
set jDpier   47

set jframep1 0
set jpierp1 0

set beam 100

         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s"  
                            

			}

#p5-p6

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   47

set iframep1 0
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   45

set jframep1 0
set jpierp1 0

set beam 200









         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 



			}

#p6-p7

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   45

set iframep1 0
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   53

set jframep1 0
set jpierp1 0

set beam 300



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 





			}

#p7-p8

for {set level 1 } {$level<= $NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   53

set iframep1 0
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   45

set jframep1 0
set jpierp1 1

set beam 400




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 





			}

#p8-p9

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   45

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  1000
set jDpier   47

set jframep1 0
set jpierp1 1

set beam 500



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}

#p9-p3

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   47

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   83

set jframep1 0
set jpierp1 0

set beam 600




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}


#----------------------------Top beams------------------------------------


#p2-p10

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  1000
set iDpier   25

set iframep1 2
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   10

set jframep1 1
set jpierp1 1

set beam 700




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}


#p10-p11

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   10

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   88

set jframep1 1
set jpierp1 1

set beam 800




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 



			}

#p11-p12

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   88

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   92

set jframep1 1
set jpierp1 1

set beam 900




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 





			}

#p12-p13

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   92

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   88

set jframep1 1
set jpierp1 2

set beam 1000




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 





			}



#p13-p14

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   88

set iframep1 1
set ipierp1 2


set jDlevel 1000000
set jDframe  100000
set jDpier   10

set jframep1 1
set jpierp1 2

set beam 1200




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 



			}

#p14-p4

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   10

set iframep1 1
set ipierp1 2


set jDlevel 1000000
set jDframe  100000
set jDpier   83

set jframep1 1
set jpierp1 0

set beam 1300



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}


#----------------left girder------------------------


#p37-p22

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   98

set iframep1 0
set ipierp1 1


set jDlevel 1000
set jDframe  100
set jDpier   7

set jframep1 2
set jpierp1 0

set beam 1400




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 



			}


#p22-p21

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000
set iDframe  100
set iDpier   7

set iframep1 2
set ipierp1 0


set jDlevel 100000
set jDframe  1000
set jDpier   13

set jframep1 2
set jpierp1 0

set beam 1500



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}

#p21-p20

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 100000
set iDframe  1000
set iDpier   13

set iframep1 2
set ipierp1 0


set jDlevel 100000
set jDframe  1000
set jDpier   13

set jframep1 1
set jpierp1 0

set beam 1600



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}


#p20-p19

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 100000
set iDframe  1000
set iDpier   13

set iframep1 1
set ipierp1 0


set jDlevel 1000
set jDframe  100
set jDpier   7

set jframep1 1
set jpierp1 0


set beam 1700



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 





			}


#p19-p38

for {set level 1 } {$level<= $NStory} {incr level 1} {

set iDlevel 1000
set iDframe  100
set iDpier   7

set iframep1 1
set ipierp1 0


set jDlevel 1000000
set jDframe  1000
set jDpier   63

set jframep1 1
set jpierp1 0


set beam 1800


         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 



			}


#--------------------right gird------------------------


#p39-p26

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   98

set iframep1 0
set ipierp1 2


set jDlevel 1000000
set jDframe  100000
set jDpier   65

set jframep1 1
set jpierp1 1

set beam 1900



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}

#p26-p25

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   65

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   73

set jframep1 1
set jpierp1 1


set beam 2000



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 





			}

#p25-p24

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   73

set iframep1 1
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   73

set jframep1 0
set jpierp1 1

set beam 2100


         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 




			}

#p24-p23

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   73

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  100000
set jDpier   65

set jframep1 0
set jpierp1 1

set beam 2200



         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 





			}

#p23-p40

for {set level 1 } {$level<=$NStory} {incr level 1} {

set iDlevel 1000000
set iDframe  100000
set iDpier   65

set iframep1 0
set ipierp1 1


set jDlevel 1000000
set jDframe  1000
set jDpier   63

set jframep1 1
set jpierp1 1

set beam 2300




         set eleTag [expr ($level*$iDlevel+$iframep1*$iDframe+$ipierp1+$iDpier+2+$beam)]
set beamuniform -4.526e3   ;# minus mwans opposite of Y direction

   set s "eleLoad ( '-ele' , $eleTag , '-type' ,  '-beamUniform' ,  $beamuniform , 0. , 0.)" ;    # BEAMS - unit N
         
#            eval $s
            puts $txt "$s" 


			}


#set s " } "
#            puts $txt "$s"





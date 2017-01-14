use <Threaded/Thread_Library.scad>

$fn=75;


module bottomCap() {
    difference() {
        union() {
            cylinder(h=4, r=25);
           
            translate([0,0,4]) {
                trapezoidThread(
                    length=10, 		
                    pitch=3, 			
                    pitchRadius=22, 	
                    threadHeightToPitch=0.5,
                    profileRatio=0.5, 
                    threadAngle=20,			
                    RH=true, 				
                    clearance=0.1, 			
                    backlash=0.1, 			
                    stepsPerTurn=24,			
                    showVertices=false);      
            }
        }
        
        translate([0,0,3]) {
            cylinder(h=14, r=18);
        }
    }
}

module bottom() {

        difference() {
            // switch mount base
            translate([-8,13,22]) {
                cube([16.5, 10, 10.5]);
            }  
            // switch mount base cutout
            translate([-7,10,23]) {
                cube([14.5, 9, 8.5]);
            }   
            // switch mount toggle/wire cutout
            translate([-5,10,21]) {
                cube([10.5, 9, 13]);
            }             
        }

        difference() {
            cylinder(h=130, r=25);
            cylinder(h=132, r=22);          
            
            // controller cutout
            translate([-21,-10,-5]) {
                cube([42, 20, 140]);
            }   
            
            // lower female threads
            translate([0,0,-2]) {
                trapezoidThread(
                    length=15, 		
                    pitch=3, 			
                    pitchRadius=23, 	
                    threadHeightToPitch=0.5,
                    profileRatio=0.5, 
                    threadAngle=20,			
                    RH=true, 				
                    clearance=0.1, 			
                    backlash=0.1, 			
                    stepsPerTurn=24,			
                    showVertices=false);      
            }   
            
            // upper female threads
            translate([0,0,118]) {
                trapezoidThread(
                    length=15, 		
                    pitch=3, 			
                    pitchRadius=23, 	
                    threadHeightToPitch=0.5,
                    profileRatio=0.5, 
                    threadAngle=20,			
                    RH=true, 				
                    clearance=0.1, 			
                    backlash=0.1, 			
                    stepsPerTurn=24,			
                    showVertices=false);      
            }     
        }
}

module middle() {
    difference() {
        union() {
            cylinder(h=96, r=20.5);
            translate([0,0,10]) {
                cylinder(h=10, r=25);
            }
            
            translate([0,0,95]) {
                trapezoidThread(
                    length=10, 		
                    pitch=3, 			
                    pitchRadius=18, 	
                    threadHeightToPitch=0.5,
                    profileRatio=0.5, 
                    threadAngle=20,			
                    RH=true, 				
                    clearance=0.1, 			
                    backlash=0.1, 			
                    stepsPerTurn=24,			
                    showVertices=false);      
            }            
            
            // top inset
            translate([0,0,85]) {
                cylinder(h=20, r=17.5);
            }
            
            translate([0,0,0]) {
                trapezoidThread(
                    length=15, 		
                    pitch=3, 			
                    pitchRadius=22, 	
                    threadHeightToPitch=0.5,
                    profileRatio=0.5, 
                    threadAngle=20,			
                    RH=true, 				
                    clearance=0.1, 			
                    backlash=0.1, 			
                    stepsPerTurn=24,			
                    showVertices=false);  
            }          
        }

        // bottom cutout
        cylinder(h=94, r=16);
        
        // top inner-cutout
        cylinder(h=110, r=14);
        
        // LED strip cutout
        translate([0,0,25]) {
            cube([40, 10, 20]);
        }
    }
}

module top() {

    // spring guide
    difference() {
        translate([0,12,40]) {
            cylinder(h=99, r=12);     
        }   
        translate([0,12,40]) {
            cylinder(h=107, r=11);     
        }   
    }  
    
    difference() {
        union() {
            
            // lower body
            translate([0,0,8]) {
                cylinder(h=33, r=20.5);
            }
            
            // upper body
            translate([0,0,40]) {
                cylinder(h=106, r=25);     
            }            
        }

        // bottom threads
        translate([0,0,7]) {
            trapezoidThread(
                length=10, 		
                pitch=3, 			
                pitchRadius=19, 	
                threadHeightToPitch=0.5,
                profileRatio=0.5, 
                threadAngle=20,			
                RH=true, 				
                clearance=0.1, 			
                backlash=0.1, 			
                stepsPerTurn=24,			
                showVertices=false);      
        }  

        // LED strip cutout
        translate([0,7,16]) {
            cube([20, 10, 20]);
        }

        // upper cutout
        translate([0,0,41]) {
            cylinder(h=110, r=23);
        }

        // lower cutout
        cylinder(h=100, r=18);   
    }
    
    // servo clips
    translate([0,0,20]) {
        difference() {
            union() {
                translate([-18.5,-6,0]) {
                    cube([37, 12, 4]);
                }
                translate([-18.5,-6,6.5]) {
                    cube([37, 12, 4]);
                }  
                
                // spring plate - add
                translate([0,0,18.5]) {
                    cylinder(h=3, r=18);
                }          
            }
            translate([-13,-10,0]) {
                cube([26, 22, 13]);
            } 
            
            // shock-cord cutout
            translate([0,-10,15]) {
                cylinder(h=10, r=1.5);
            }  
            
            // spring plate -remove
            translate([-18.5,6,18.5]) {
                cube([37, 12, 4]);
            }
        }
    } 
}

module topCap() {
    difference() {
        union() {
            // top outer
            translate([0,0,5]) {
                cylinder(h=10, r=25);
            }       
    
            // top inner
            cylinder(h=5, r=21.5); 
            
            // shock-cord nub
            translate([0,-11,-6]) {
                cylinder(h=15, r=5);
            }              
            
            // servo connector - spring plunger
            translate([0,11.5,-50]) {
                cylinder(h=50, r=10);
            }             
            // servo connector
            translate([0,11.5,-109]) {
                cylinder(h=117, r=5);
            } 
        }   
        
        // shock-cord cutout
        rotate([0, 90, 0]) {
            translate([3,-11,-11]) {
                cylinder(h=20, r=1.5);
            }   
        }
                   
        // servo cutout
        rotate([0, 0, 80]) {
            translate([1,-8,-106]) {
                cube([10, 20, 5]);
            }
        }
    }
}

//color("Yellow") {
//    bottomCap();
//}
//
//color("Purple") {
//    translate([0,0,25]) {
//        bottom();
//    }
//}
//
color("Green") {
    translate([0,0,160]) {
        middle();
    }
}

//color("Red") {
//    translate([0,0,265]) {
//        top();
//    }
//}
//color("Purple") {
//    translate([0,0,480]) {
//        topCap();
//    }
//}








 






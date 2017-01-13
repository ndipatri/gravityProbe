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
        cylinder(h=110, r=25);
        cylinder(h=112, r=22);
        
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
        
        translate([0,0,98]) {
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
        
        translate([0,0,25]) {
            cube([40, 10, 20]);
        }
    }
}

module top() {
    difference() {
        union() {
            translate([0,0,8]) {
                cylinder(h=33, r=20.5);
            }
            translate([0,0,40]) {
                cylinder(h=46, r=25);     
            }  
        }

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

        // lower cutout
        cylinder(h=100, r=18);   
            
        // upper cutout
        translate([0,0,41]) {
            cylinder(h=50, r=23);
        }
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
            // top outter
            translate([0,0,5]) {
                cylinder(h=10, r=25);
            }       
    
            // top inner
            cylinder(h=5, r=21.5); 
            
            // servo connector support
            translate([0,11.5,-3]) {
                cylinder(h=4, r=8);
            }             
            // servo connector
            translate([0,11.5,-49]) {
                cylinder(h=57, r=5);
            } 
        }   
        
        // shock-cord cutout
        rotate([0, 90, 0]) {
            translate([10,12,-10]) {
                cylinder(h=20, r=1.5);
            }   
        }
                   
        // servo cutout
        rotate([0, 0, 80]) {
            translate([1,-8,-45]) {
                cube([10, 20, 5]);
            }
        }
        
     
    }
}

color("Yellow") {
    bottomCap();
}

color("Purple") {
    translate([0,0,25]) {
        bottom();
    }
}

color("Green") {
    translate([0,0,143]) {
        middle();
    }
}

color("Red") {
    translate([0,0,243]) {
        top();
    }
}
color("Purple") {
    translate([0,0,330]) {
        topCap();
    }
}








 






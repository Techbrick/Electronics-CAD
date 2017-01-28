include <hardware.scad>

//adj_ir();
//sr04();

//housing1();

translate([0,13,0]) tophalf();
translate([0,-13,0]) rotate(180) bottomhalf();

module tophalf(){
    translate([0,0,12.7])
    rotate([0,180,0])
    intersection(){
        housing1();
        translate([0,0,12.7/2])
        cube([6*25.4,2*25.4,12.7],center=true);
    }
}

module bottomhalf(){
    translate([0,0,12.7])
    intersection(){
        housing1();
        translate([0,0,-12.7/2])
        cube([6*25.4,2*25.4,12.7],center=true);
    }
}

module housing1(){
    difference(){
        translate([12.7,0,0]){
            difference(){
                translate([-25.4,0,0])
                cube([25.4*2,25.4,25.4],center=true);
                translate([12.7,-55/2+12.7,0])
                adj_ir();
                translate([-25.4,0,0])
                rotate([0,0,0])
                sr04();
            }
            difference(){
                translate([25.4,-12.7/2,0])
                cube([25.4*2,12.7,25.4],center=true);
                translate([12.7,-14,0])
                adj_ir();
            }
            translate([-25.4*2.5,-12.7/2,0])
            cube([25.4,12.7,25.4],center=true);
        }
        for (x = [-2,2,],z=[-.25,.25]){
            translate([x*25.4,-26,z*25.4])
            rotate([-90,0,0])
//            rotate(360/12)
            cylinder_outer(52,1/4*25.4/2,6);
        }
        for(x = [-1.75,1.75,2.25,-2.25]){
            translate([x*25.4,-12.7/2,-20])
            rotate(360/16)
            cylinder_outer(40,25.4/4/2,8);
        }
    }
}

module adj_ir(){
    translate([0,-55/2,0])
    rotate([-90,00,0]){
        irlong = 55;
        cylinder_outer(irlong, 9, 16);
        translate([0,0,irlong-12.7])
        cylinder_outer(12.7, 27/2, 16);
        cylinder_outer(irlong-12.7-15,27/2,16);
    }
}

module sr04(){
    sonar_spacing=41-16;
    tolerance = 0.6;
    rotate([-90,0,0]){
        for(x = [-sonar_spacing/2,sonar_spacing/2]){
            translate([x,0,0])
            cylinder(r=8+tolerance,h=15);
        }
        translate([0,0,.75])
        cube([45.5+tolerance,20.5+tolerance,1.8],center=true);
        hull(){
            /*for(x = [-3,3]){
                translate([x,7.5,0])
                cylinder(r=2.5+tolerance,h=6,$fn=16);
            }*/
            // Special crystal for vertical insertion
            for(x = [-3,3]){
                translate([x,7.5,0])
                cylinder(r=2.5+tolerance,h=6,$fn=16);
            }
            for(x = [-sonar_spacing/2,sonar_spacing/2]){
                translate([x,0,0])
                cylinder(r=8+tolerance,h=6);
            }
        }
        for(i = [-1,1]){
            translate([i*41.5/2,i*16.5/2,-2])
            cylinder(r=1,h=15,$fn=16);
        }
        translate([0,-18.5/2,0])
        cube([11,3,9],center=true);
        translate([0,-18.5/2-20/2+1.5,-2])
        cube([13,20,8],center=true);
        difference(){
            translate([0,0,-1.25])
            //cube([45.5,20.5,3.5],center=true);
            cube([45.5+tolerance,20.5+tolerance,3.5],center=true);
            /*
            for(i = [-1,1]){
                translate([i*41.5/2,i*16.5/2,-5])
                cylinder(r=2,h=15,$fn=16);
                
            }*/
        }
    }
}


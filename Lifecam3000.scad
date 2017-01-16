// Created by Caitlyn Byrne
// CC-BY-NC

// Note, you will need the 'cameramount' file from the following thing:
// http://www.thingiverse.com/thing:1494829

include <hardware.scad>

led = "rings"; // [none:No LEDs,cree:Cree Board w/ 1in heatsink,ring:LED Ring]

r60 = [50.17, 66.68];
r80 = [63.63, 80.14];
r100 = [83.57, 100.08];
r120 = [102.87,119.38];

rings = [r60];
//rings = [r80,r100,r120];

wallthick = 2;

lifecam_tall = 37.5;
lifecam_wide = 44.5;
lifecam_thick = 20.75; // measured from z=0 to the top of the mounted lifecam edge

case_screw = i8;

mount_screw = i8;
mount_screw_spacing = 25.4;

// cree_mount_x = (1.813-0.350)*25.4; // = 37.1602mm, which is hard to machine
cree_mount_x = 23/16*25.4; // changed to 23/16 in, so easier to make by hand.
echo(cree_mount_x=cree_mount_x);
cree_mount_y = 0.5*25.4;
cree_screw = i8;
cree_heatsink_width = 25.4;

//bot();
top();
//lifecam_rings();


module bot(){
    translate([0,0,lifecam_thick+wallthick])
    rotate([0,180,0])
    %lifecam_mount_top();

    lifecam_mount_bot();
    
    if (led == "ring"){
        %translate([0,0,lifecam_thick+wallthick*3])
        rotate([0,180,0])
        lifecam_rings();
    }
}

module top(){
//    translate([0,0,lifecam_thick+wallthick])
//    rotate([0,180,0])
//    %lifecam_mount_bot();

    lifecam_mount_top();
}


module lifecam_rings(){
    difference(){
        union(){
            for( ringid = [0:1:len(rings)-1]){
               cylinder_outer(wallthick*2, (rings[ringid][1]+wallthick*2)/2, 64);
            } 
            translate([0,0,wallthick])
            cube([lifecam_wide+wallthick*8+case_screw[nut_thick]*2, wallthick*2+lifecam_tall, wallthick*2],center=true);
            for (x = [-1,1]){
                translate([x*(lifecam_wide+wallthick*7+case_screw[nut_thick]*2)/2,0,(lifecam_thick+wallthick*3)/2])
                cube([wallthick, lifecam_tall+wallthick*2,lifecam_thick+wallthick*3],center=true);
            }
        }
        for( ringid = [0:1:len(rings)-1]){
            difference(){
                translate([0,0,-1])
                cylinder_outer(wallthick+1, (rings[ringid][1])/2+0.1, 64);
                
                translate([0,0,-2])
                cylinder(h = wallthick*3, d = rings[ringid][0]-0.2,$fn=64);
            }
            holedist = (((rings[ringid][1]-rings[ringid][0])/2)+rings[ringid][0])/2;
            echo(holedist = holedist);
            translate([0,holedist,-1])
            rotate(90)
            bolt_head((rings[ringid][1]-rings[ringid][0])/2,wallthick+0.95,5,true,0.35);
            translate([0,holedist,-1])
            rotate(360/32)
            cylinder(d=5,h=wallthick*4,$fn=16);
            
            
            rotate_extrude($fn=64)
            translate([rings[ringid][0]/2, 0,0])
            rotate(45)
            square(0.5,center=true);
            rotate_extrude($fn=64)
            translate([rings[ringid][1]/2, 0,0])
            rotate(45)
            square(0.5,center=true);
        }
        translate([0,0,-1])
        cylinder(d = 40, h = wallthick*4);
        
        for(x = [-1,1],y=[-1,1,0]){
            translate([x*(lifecam_wide+wallthick*5+case_screw[nut_thick])/2-6,y*mount_screw_spacing/2,(lifecam_thick)/2+wallthick*3])
            rotate([0,90,0])
            rotate(360/12)
            cylinder_outer(12,case_screw[machine_screw_diameter]/2,6);
        }
        
    }
    
}

module lifecam_mount_top(){
    camopeningx = 38;
    camopeningy = 25;
    difference(){
        union(){
            if (led == "cree"){
                translate([0,(cree_heatsink_width+wallthick)/2,(wallthick)/2])
                cube([lifecam_wide+wallthick*6+case_screw[nut_thick]*2, lifecam_tall+cree_heatsink_width+wallthick*3,wallthick],center=true);
            } else {
                translate([0,0,(wallthick)/2])
                cube([lifecam_wide+wallthick*6+case_screw[nut_thick]*2, lifecam_tall+wallthick*2,wallthick],center=true);
            }
            if (led == "cree"){   
                translate([0,lifecam_tall/2+wallthick+cree_heatsink_width/2,0.5])
                rotate(360/64)
                cylinder_outer2(lifecam_thick-0.5,cree_heatsink_width/2+wallthick,22/2+wallthick,32);
            }
            
            // nut pusher tabs
            for(x = [-1,1],y=[-1,1,0]){
                translate([x*(lifecam_wide+wallthick*2+case_screw[nut_thick])/2,y*mount_screw_spacing/2,10])
                cube([case_screw[nut_thick]-0.5, case_screw[nut_wide]-0.5,20],center=true);
            }
            
            // bottom wall
            translate([0,-1*(wallthick+lifecam_tall)/2,(lifecam_thick+wallthick)/2])
            cube([lifecam_wide+wallthick*6+case_screw[nut_thick]*2,wallthick,lifecam_thick+wallthick],center=true);
            
            // mid wall & top wall
            if (led == "cree"){
                translate([0,1*(wallthick+lifecam_tall)/2,(lifecam_thick)/2])
                cube([lifecam_wide,wallthick,lifecam_thick],center=true);
                
                translate([0,(wallthick+lifecam_tall)/2+cree_heatsink_width+wallthick,(lifecam_thick+wallthick)/2])
                cube([lifecam_wide+wallthick*6+case_screw[nut_thick]*2,wallthick,lifecam_thick+wallthick],center=true);
            } else {
                translate([0,1*(wallthick+lifecam_tall)/2,(lifecam_thick+wallthick)/2])
                cube([lifecam_wide+wallthick*6+case_screw[nut_thick]*2,wallthick,lifecam_thick+wallthick],center=true);
            }
            
            // side walls
            if (led == "cree"){
                for (x = [-1,1]){
                    translate([x*(lifecam_wide+wallthick*5+case_screw[nut_thick]*2)/2,(wallthick+cree_heatsink_width)/2,(lifecam_thick+wallthick)/2])
                    cube([wallthick, lifecam_tall+wallthick*3+cree_heatsink_width,lifecam_thick+wallthick],center=true);
                }
            } else {
                for (x = [-1,1]){
                    translate([x*(lifecam_wide+wallthick*5+case_screw[nut_thick]*2)/2,0,(lifecam_thick+wallthick)/2])
                    cube([wallthick, lifecam_tall+wallthick*2,lifecam_thick+wallthick],center=true);
                }
            }
            
        }
        
        // camera cutouts
        cube([camopeningx, camopeningy, wallthick*3],center=true);
        
        for (y = [-camopeningy/2:camopeningy/8:camopeningy/2]){
            translate([0,y,0])
            cube([camopeningx+10,1,wallthick*3],center=true);
        }
        
        for (x = [-camopeningx/2:camopeningx/12:camopeningx/2]){
            translate([x,0,0])
            cube([1,camopeningy+10,wallthick*3],center=true);
        }
        
        // led hole
        if (led == "cree"){   
            translate([0,lifecam_tall/2+wallthick+cree_heatsink_width/2,-1])
            rotate(360/64)
            cylinder_outer2(lifecam_thick+wallthick+2,cree_heatsink_width/2,22/2,32);
        }
        
        // mounting hole cutouts
        for(x = [-1,1],y=[-1,1,0]){
            translate([x*(lifecam_wide+wallthick*2+case_screw[nut_thick])/2-6,y*mount_screw_spacing/2,(lifecam_thick)/2+wallthick])
            rotate([0,90,0])
            rotate(360/12)
            cylinder_outer(12,case_screw[machine_screw_diameter]/2,6);
            
            translate([x*(lifecam_wide+wallthick*2+case_screw[nut_thick])/2,y*mount_screw_spacing/2,lifecam_thick+wallthick])
            rotate([0,90,0])
            hull()
            for(x2 = [-1,1]){
                translate([x2*lifecam_thick/2,0,-case_screw[nut_thick]/2])
                cylinder_outer(case_screw[nut_thick],case_screw[nut_wide]/2,6);
            }
            
        }

        for (x = [-1,1]){
            translate([x*(lifecam_wide+wallthick*6+case_screw[nut_thick]*2)/2,0,0])
            rotate([0,45,0])
            cube([1,200,1],center=true);
        }
        if (led == "cree"){
            for (y = [-(lifecam_tall+wallthick*2)/2,(lifecam_tall+wallthick*2)/2+cree_heatsink_width+wallthick]){
                translate([0,y,0])
                rotate([45,0,0])
                cube([200,1,1],center=true);
            }
        } else {
            for (y = [-1,1]){
                translate([0,y*(lifecam_tall+wallthick*2)/2,0])
                rotate([45,0,0])
                cube([200,1,1],center=true);
            }
        }
        
    }
}

module lifecam_mount_bot(){
    
    difference(){
        // main geometry
        union(){
            // Tab for camera
            translate([0,-11,0.5])
            lifecam_mounttab();
            
            // bottom plate and USB hole
            difference(){
                if (led == "cree"){
                    translate([0,cree_heatsink_width/2+wallthick/2,wallthick/2])
                    cube([lifecam_wide+wallthick*4+case_screw[nut_thick]*2, lifecam_tall+cree_heatsink_width+wallthick,wallthick],center=true);
                } else {
                    translate([0,0,wallthick/2])
                    cube([lifecam_wide+wallthick*4+case_screw[nut_thick]*2, lifecam_tall,wallthick],center=true);
                }
                cube([16,8,wallthick*3],center=true);
                cylinder(h=wallthick*3, d=12,center=true);
            }
            
            // back camera 'support'
            lifecamsupport = 2.25;
            translate([0,11,lifecamsupport/2+wallthick])
            cube([lifecam_wide/2, wallthick, lifecamsupport],center=true);
            
            // Side Walls
            for(x = [-1,1]){
                if (led == "cree"){
                    translate([x*(lifecam_wide+wallthick*2+case_screw[nut_thick])/2, cree_heatsink_width/2+wallthick/2, (lifecam_thick)/2])
                    cube([wallthick*2+case_screw[nut_thick],lifecam_tall+cree_heatsink_width+wallthick,lifecam_thick],center=true);
                } else {
                    translate([x*(lifecam_wide+wallthick*2+case_screw[nut_thick])/2, 0, (lifecam_thick)/2])
                    cube([wallthick*2+case_screw[nut_thick],lifecam_tall,lifecam_thick],center=true);
                }
            }
        }
        
        // nut slots for case
        for(x = [-1,1],y=[-1,1,0]){
            translate([x*(lifecam_wide+wallthick*2+case_screw[nut_thick])/2,y*mount_screw_spacing/2,lifecam_thick])
            rotate([0,90,0])
            hull()
            for(x2 = [-1,1]){
                translate([x2*lifecam_thick/2,0,-case_screw[nut_thick]/2])
                cylinder_outer(case_screw[nut_thick],case_screw[nut_wide]/2,6);
            }
            translate([x*(lifecam_wide+wallthick*2+case_screw[nut_thick])/2-6,y*mount_screw_spacing/2,(lifecam_thick)/2])
            rotate([0,90,0])
            rotate(360/12)
            cylinder_outer(12,case_screw[machine_screw_diameter]/2,6);
        }
  
        if (led == "cree"){
            translate([0,(lifecam_tall)/2+wallthick+cree_heatsink_width/2,0])
            for (x = [-1,1], y = [-1,1]){
                translate([x*cree_mount_x/2, y*cree_mount_y/2,-1])
                cylinder_outer(wallthick*2,cree_screw[machine_screw_diameter]/2+0.5, 16);
                translate([x*cree_mount_x/2, y*cree_mount_y/2,wallthick+0.05])
                cylinder_outer(50,cree_screw[pan_head_diameter]/2+0.7, 16);
            }
            
            translate([0,(lifecam_tall)/2+wallthick+cree_heatsink_width/2,-1])
            rotate(360/64)
            cylinder_outer(wallthick*2, 22/2, 32);
        }
        
        for(x = [-1,1]){
            translate([x*(lifecam_wide+wallthick*4+case_screw[nut_thick]*2)/2, 0,0])
            rotate([0,45,0])
            cube([1,200,1],center=true);
        }
        
        if (led == "cree"){
            for (y = [-(lifecam_tall)/2, (lifecam_tall)/2+cree_heatsink_width+wallthick]){
                translate([0,y,0])
                rotate([45,0,0])
                cube([200,1,1],center=true);
            }
        } else {
            for (y = [-1,1]){
                translate([0,y*lifecam_tall/2,0])
                rotate([45,0,0])
                cube([200,1,1],center=true);
            }
        }

    }
}

module lifecam_mounttab(){
    render()
    intersection(){
            
        translate([0,0,3])
        import("D:\\Documents\\DIY Projects\\lifecammounttab.stl", 6);
        
        translate([0,0,10])
        cube([40,5,20],center=true);
    }
}


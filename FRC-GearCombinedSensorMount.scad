include <hardware.scad>

wallthick = 2;

lifecam_tall = 37.5;
lifecam_wide = 44.5;
lifecam_thick = 19.25;
lifecam_fov = 60;

heatsink_tall = 25.4;
heatsink_wide = 1.82*25.4;
heatsink_thick = 50.8;

tall = 24;

import("gearcasing.stl", 10);

lifecam_offset = [lifecam_wide/2+wallthick+heatsink_tall/2,0,tall-lifecam_thick-wallthick];
heatsink_offset = [0,0,tall-heatsink_thick/2-wallthick];

housingbottom();

module housingbottom(){
    difference(){
        cylinder(d=4.75*25.4, h = tall);
        translate([-50-(.85+6/8)/2*25.4+1,0,0])
        cube([100,300,70],center=true);
        
        translate(heatsink_offset)
        heatsink_cut();
        
    }
}

module heatsink_cut(){
    cree_mount_y = 23/16*25.4;
    cree_mount_x = 0.5*25.4;
    cree_screw = i6;
    cube([heatsink_tall, heatsink_wide, heatsink_thick],center=true);
    // led hole  
    translate([0,0,heatsink_thick/2-1]){
        rotate(360/64)
        cylinder_outer(50,22/2,32);
        
        for(x = [-1,1], y = [-1,1]){
            translate([x*cree_mount_x/2,y*cree_mount_y/2,0])
            cylinder_outer(50,cree_screw[machine_screw_diameter]/2+0.5,16);
        }
    
    }
}

module lifecam_mount_bottom_cut(){
    
    %translate([0,0,lifecam_thick/2]) cube([lifecam_wide,lifecam_tall,lifecam_thick],center=true);
    difference(){
        // main geometry
        union(){
            // Tab for camera
            translate([0,-11,0.5])
            lifecam_mounttab();
            
            // bottom plate and USB hole
            difference(){
                translate([0,0,wallthick/2])
                cube([lifecam_wide, lifecam_tall,wallthick],center=true);
                cube([17,9,wallthick*3],center=true);
                cylinder(h=wallthick*3, d=14,center=true);
            }
            
            // back camera 'support'
            lifecamsupport = 2.25;
            translate([0,11,lifecamsupport/2+wallthick])
            cube([lifecam_wide/2, wallthick, lifecamsupport],center=true);
            
            // turn on for FOV cone
            translate([0,0,lifecam_thick/2])
            %cylinder(r1=0,r2=tan(lifecam_fov/2)*40,h=40);
        }
    }
}


module lifecam_mount_bottom_add(){
    
    %translate([0,0,lifecam_thick/2]) cube([lifecam_wide,lifecam_tall,lifecam_thick],center=true);
    difference(){
        // main geometry
        union(){
            // Tab for camera
            translate([0,-11,0.5])
            lifecam_mounttab();
            
            // bottom plate and USB hole
            difference(){
                translate([0,0,wallthick/2])
                cube([lifecam_wide, lifecam_tall,wallthick],center=true);
                cube([17,9,wallthick*3],center=true);
                cylinder(h=wallthick*3, d=14,center=true);
            }
            
            // back camera 'support'
            lifecamsupport = 2.25;
            translate([0,11,lifecamsupport/2+wallthick])
            cube([lifecam_wide/2, wallthick, lifecamsupport],center=true);
            
            // turn on for FOV cone
            translate([0,0,lifecam_thick/2])
            %cylinder(r1=0,r2=tan(lifecam_fov/2)*40,h=40);
        }
    }
}

module lifecam_mounttab(){
    render()
    intersection(){
            
        translate([0,0,3])
        import("lifecammounttab.stl", 6);
        
        translate([0,0,10])
        cube([40,5,20],center=true);
    }
}

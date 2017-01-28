wallthick = 2;

lifecam_tall = 37.5;
lifecam_wide = 44.5;
lifecam_thick = 19.25;
lifecam_fov = 60;

heatsink_tall = 25.4;
heatsink_wide = 1.82*25.4;
heatsink_thick = 50.8;

tall = 24.5;

import("gearcasing.stl", 10);

translate([lifecam_wide/2+wallthick+heatsink_tall/2,0,tall-lifecam_thick-wallthick])
lifecam_mount_bot();




module lifecam_mount_bot(){
    
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

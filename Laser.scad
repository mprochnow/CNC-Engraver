// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains part(s) for mouting a laser module

include <Measurements.scad>


module laser_module_mount() {
    difference() {
        union() {
            translate([-laser_module_width/2, 0, 0])
                cube([laser_module_width, sk20_depth, sk20_rail_mount_offset-laser_module_depth/2]);
            
            translate([-sk20_base_width/2, 0, 0])
                cube([sk20_base_width, sk20_depth, sk20_base_height]);
        }

        for (i=[-1, 1])
        translate([i*sk20_mount_screw_distance/2, sk20_depth/2, -0.1])
            cylinder(d=sk20_mount_screw_dia+play, h=sk20_base_height+0.2, $fn=64);

        translate([0, laser_module_height/2-(laser_module_mount_screw_distance2-laser_module_mount_screw_distance), 0])
        translate([0, laser_module_height/2, 0]) {
            translate([0, -laser_module_mount_screw_distance/2, sk20_rail_mount_offset-laser_module_depth/2-5])
                cylinder(d=3+play, h=5.1, $fn=16);
                
            translate([0, -laser_module_mount_screw_distance/2, -0.1])
                cylinder(d=m3_screw_head_dia+play, h=sk20_rail_mount_offset-laser_module_depth/2-5-0.1, $fn=32);

            translate([0, -laser_module_mount_screw_distance2/2, sk20_rail_mount_offset-laser_module_depth/2-5])
                cylinder(d=3+play, h=5.1, $fn=16);
                
            translate([0, -laser_module_mount_screw_distance2/2, -0.1])
                cylinder(d=m3_screw_head_dia+play, h=sk20_rail_mount_offset-laser_module_depth/2-5-0.1, $fn=32);
        }
    }
}

module laser_module() {
    translate([-laser_module_width/2, -laser_module_depth/2, 0])
    color("gray")
        cube([laser_module_width, laser_module_depth, laser_module_height]);
    
    translate([0, 0, -10])
    color("gray")
        cylinder(d=15, h=10, $fn=16);
}

laser_module_mount();

// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains the drill templates for the aluminium plates.

include <Measurements.scad>


module x_axis_carriage_drill_template() {
    dia = 1.5;
    h = 0.6;
    width = 5+1+nema17_width+1+5;
    depth = (z_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2-608_bearing_od/2-3*nozzle_width-5+nema17_width/2+5;
    height = stepper_motor_length;

    translate([0, -z_axis_smooth_rod_length/2, 0])
    difference() {
        translate([-z_axis_base_width/2, 0, 0])
            cube([z_axis_base_width, z_axis_smooth_rod_length, h]);
        
        // z_axis_floating_bearing_block_base
        for (i=[-1, 1]) {
            translate([i*(608_bearing_od/2+(z_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), profile_width/2, -0.1])
                cylinder(d=dia, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+8)/4), profile_width/2, -0.1])
                cylinder(d=dia, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
        }

        // z_axis_fixed_bearing_block_base
        for (i=[-1, 1]) {
            translate([i*(608_bearing_od/2+(z_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), z_axis_smooth_rod_length-profile_width/2, -0.1])
                cylinder(d=dia, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+8)/4), z_axis_smooth_rod_length-profile_width/2, -0.1])
                cylinder(d=dia, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
        }
        
        // z_axis_motor_holder
        translate([0, z_axis_smooth_rod_length-height/2-2.5, -0.1]) {
            for (i=[-1, 1])
            for (j=[-1, 0, 1])
            translate([i*(width+7)/2, j*(height+5)/3], 0)
                cylinder(d=dia, h=5.2, $fn=32);
        }
        
        translate([-lm8uu_length, z_axis_base_width/2, 0])
        rotate([90, 0, 90]) {
            for (i=[0, 1])
            mirror([i, 0, 0])
            for (i=[-1, 1])
            translate([z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+lm8uu_od)/4, -0.1, lm8uu_length+i*lm8uu_length/2])
            rotate([-90, 0, 0])
                cylinder(d=dia, h=2+3*nozzle_width+608_bearing_od/2+lm8uu_od/2+3*nozzle_width+0.2, $fn=32);
            
            for (i=[-1, 1])
            translate([i*anti_backlash_nut_screw_distance/2, -0.1, lm8uu_length-anti_backlash_nut_depth/2-anti_backlash_nut_screw_offset])
            rotate([-90, 0, 0])
                cylinder(d=dia, h=2+3*nozzle_width+608_bearing_od/2, $fn=32);
        }
    }
}

module z_axis_carriage_drill_template() {
    dia = 1.5;
    h = 0.6;
    
    difference() {
        translate([-z_axis_base_width/2, 0, 0])
            cube([z_axis_base_width, z_axis_carriage_height, h]);

        translate([0, 10, 0])
        for (i=[-1, 1])
        translate([i*22.5, 0, -0.1])
            cylinder(d=dia, h=h+0.2, $fn=16);
            
        translate([0, z_axis_carriage_height, 0])
        rotate([90, 0, 0])
        for (i=[0, 1])
        mirror([i, 0, 0])
        for (i=[-1, 1])
        translate([z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+lm8uu_od)/4, -0.1, lm8uu_length+i*lm8uu_length/2])
        rotate([-90, 0, 0])
            cylinder(d=dia, h=2+3*nozzle_width+608_bearing_od/2+lm8uu_od/2+3*nozzle_width+0.2, $fn=32);
            
        translate([0, z_axis_carriage_height, 0])
        rotate([90, 0, 0])
        for (i=[-1, 1])
        translate([i*anti_backlash_nut_screw_distance/2, -0.1, lm8uu_length+anti_backlash_nut_depth/2+anti_backlash_nut_screw_offset])
        rotate([-90, 0, 0])
            cylinder(d=dia, h=2+3*nozzle_width+608_bearing_od/2, $fn=32);
    }
}


*z_axis_carriage_drill_template();

*x_axis_carriage_drill_template();



// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains the parts for the z-axis.

include <Measurements.scad>


module z_axis_floating_bearing_block_base() {
    difference() {
        translate([-z_axis_base_width/2, play/2, 0])
            cube([z_axis_base_width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
        
        for (i=[-1, 1]) {
            translate([i*z_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=z_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);
            
            translate([i*(608_bearing_od/2+(z_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+8)/4), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
        }
        
        translate([0, 0, -0.1])
            cylinder(d=608_bearing_od-2, h=profile_width+0.2, $fn=64);

        translate([0, 0, profile_width/2+608_bearing_height/2])
            cylinder(d1=608_bearing_od+play, d2=608_bearing_od-2, h=1, $fn=64);
        
        translate([0, 0, profile_width/2-(608_bearing_height+0.2)/2])
            cylinder(d=608_bearing_od+play, h=608_bearing_height+0.2, $fn=64);

        translate([0, 0, profile_width/2-608_bearing_height/2-1])
            cylinder(d1=608_bearing_od-2, d2=608_bearing_od+play, h=1, $fn=64);
    }
}

module z_axis_floating_bearing_block_top() {
    difference() {
        union() {
            translate([-z_axis_base_width/2, 0, 0])
                cube([z_axis_base_width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
                
            difference() {
                translate([0, 3*nozzle_width+608_bearing_od/2, 0])
                    cylinder(d=608_bearing_od+8*nozzle_width, h=profile_width, $fn=64);
                
                translate([-4*nozzle_width-608_bearing_od/2-0.1, 3*nozzle_width+608_bearing_od/2-play/2, -0.1])
                    cube([8*nozzle_width+608_bearing_od+0.2, 4*nozzle_width+608_bearing_od/2+0.2, profile_width+0.2]);
            }
        }

        for (i=[-1, 1]) {
            translate([i*(608_bearing_od/2+(z_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1+0.1, $fn=32);
            }
            
            translate([i*(z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+8)/4), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1+0.1, $fn=32);
            }
        }
        
        translate([0, 3*nozzle_width+608_bearing_od/2, 0]) {
            for (i=[-1, 1])
            translate([i*z_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=z_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);

            translate([0, 0, -0.1])
                cylinder(d=608_bearing_od-2, h=profile_width+0.2, $fn=64);

            translate([0, 0, profile_width/2+608_bearing_height/2])
                cylinder(d1=608_bearing_od+play, d2=608_bearing_od-2, h=1, $fn=64);
            
            translate([0, 0, profile_width/2-(608_bearing_height+0.2)/2])
                cylinder(d=608_bearing_od+play, h=608_bearing_height+0.2, $fn=64);

            translate([0, 0, profile_width/2-608_bearing_height/2-1])
                cylinder(d1=608_bearing_od-2, d2=608_bearing_od+play, h=1, $fn=64);
        }
    }
}

module z_axis_fixed_bearing_block_base() {
    difference() {
        translate([-z_axis_base_width/2, play/2, 0])
            cube([z_axis_base_width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
        
        for (i=[-1, 1]) {
            translate([i*z_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=8+play, h=profile_width+0.2, $fn=32);
            
            translate([i*(608_bearing_od/2+(z_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+8)/4), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
        }
        
        translate([0, 0, -0.1])
            cylinder(d=608_bearing_od-2, h=profile_width+0.2, $fn=64);

        translate([0, 0, -0.1])
            cylinder(d=608_bearing_od, h=608_bearing_height+0.2, $fn=64);
        
        translate([0, 0, 608_bearing_height])
            cylinder(d1=608_bearing_od, d2=608_bearing_od-2, h=1, $fn=64);
        
        translate([0, 0, profile_width-608_bearing_height-1])
            cylinder(d1=608_bearing_od-2, d2=608_bearing_od, h=1, $fn=64);
        
        translate([0, 0, profile_width-608_bearing_height-0.1])
            cylinder(d=608_bearing_od, h=608_bearing_height+0.2, $fn=64);
    }
}

module z_axis_fixed_bearing_block_top() {
    difference() {
        union() {
            translate([-z_axis_base_width/2, 0, 0])
                cube([z_axis_base_width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
            
            // endstop mount
            hull() {
                translate([-12.5, 0, 0])
                    cube([25, 1, profile_width]);

                translate([-10, -2.5, 0])
                    cube([20, 1, profile_width]);
            }
        }
        
        // endstop mounting screws
        for (i=[-5, 5])
        translate([i, -2.6, 9])
        rotate([-90, 0, 0]) {
            cylinder(d=2.5+play, h=20, $fn=16);
            
            translate([0, 0, 2])
            rotate([0, 0, 30])
                hex_nut(m2_5_nut_width+play, 10);
        }
        
        for (i=[-1, 1]) {
            translate([i*(608_bearing_od/2+(z_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1+0.1, $fn=32);
            }
            
            translate([i*(z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+8)/4), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1+0.1, $fn=32);
            }
        }
        
        translate([0, 3*nozzle_width+608_bearing_od/2, 0]) {
            for (i=[-1, 1])
            translate([i*z_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=z_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);

            translate([0, 0, -0.1])
                cylinder(d=608_bearing_od-2, h=profile_width+0.2, $fn=64);

            translate([0, 0, -0.1])
                cylinder(d=608_bearing_od, h=608_bearing_height+0.2, $fn=64);
            
            translate([0, 0, 608_bearing_height])
                cylinder(d1=608_bearing_od, d2=608_bearing_od-2, h=1, $fn=64);
            
            translate([0, 0, profile_width-608_bearing_height-1])
                cylinder(d1=608_bearing_od-2, d2=608_bearing_od, h=1, $fn=64);
            
            translate([0, 0, profile_width-608_bearing_height-0.1])
                cylinder(d=608_bearing_od, h=608_bearing_height+0.2, $fn=64);
        }
    }
}

module z_axis_bearing_mount() {
    difference() {
        union() {
            translate([-z_axis_base_width/2, 0, 0])
                cube([z_axis_base_width, 2+3*nozzle_width+608_bearing_od/2-anti_backlash_nut_height/2, lm8uu_length]);
                
            for (i=[0, 1])
            mirror([i, 0, 0]) {
                translate([z_axis_smooth_rod_distance/2-lm8uu_od/2-6*nozzle_width, 0, 0])
                    cube([lm8uu_od/2+6*nozzle_width+(z_axis_base_width-z_axis_smooth_rod_distance)/2, 2+3*nozzle_width+608_bearing_od/2, 2*lm8uu_length]);
                
                hull() {
                    translate([z_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, 0])
                        cylinder(d=lm8uu_od+2*6*nozzle_width, h=2*lm8uu_length, $fn=64);

                    translate([z_axis_base_width/2-6*nozzle_width-lm8uu_od/2, 2+3*nozzle_width+608_bearing_od/2, 0])
                        cylinder(d=lm8uu_od+2*6*nozzle_width, h=2*lm8uu_length, $fn=64);
                }
            }
            
            for (i=[-1, 1])
            translate([z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+lm8uu_od)/4, -0.1, lm8uu_length+i*lm8uu_length/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=21, $fn=32);
            }
        }
        
        for (i=[0, 1])
        mirror([i, 0, 0]) {
            translate([z_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, -0.1])
                cylinder(d=lm8uu_od+play, h=2*lm8uu_length+0.2, $fn=64);
                
            translate([z_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, -0.1])
                cube([lm8uu_od/2+3*nozzle_width+(z_axis_base_width-z_axis_smooth_rod_distance)/2, 1, 2*lm8uu_length+0.2]);
            
            for (i=[-1, 1])
            translate([z_axis_smooth_rod_distance/2+(z_axis_base_width-z_axis_smooth_rod_distance+lm8uu_od)/4, -0.1, lm8uu_length+i*lm8uu_length/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=2+3*nozzle_width+608_bearing_od/2+lm8uu_od/2+3*nozzle_width+0.2, $fn=32);
                
                translate([0, 21, 0])
                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=20, $fn=32);
            }
        }
        
        for (i=[-1, 1])
        translate([i*anti_backlash_nut_screw_distance/2, -0.1, lm8uu_length-anti_backlash_nut_depth/2-anti_backlash_nut_screw_offset])
        rotate([-90, 0, 0])
            cylinder(d=anti_backlash_nut_screw_dia+play, h=2+3*nozzle_width+608_bearing_od/2, $fn=32);
    }
}

module z_axis_motor_holder() {
    width = 5+1+nema17_width+1+5;
    depth = (z_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2-608_bearing_od/2-3*nozzle_width-5+nema17_width/2+5;
    height = stepper_motor_length;

    difference() {
        union() {
            translate([-width/2, 3*nozzle_width+608_bearing_od+3*nozzle_width+5, 0])
                cube([width, depth, 5]);

            for (i=[-1, 1])
            translate([-2.5+i*(width/2-2.5), 3*nozzle_width+608_bearing_od+3*nozzle_width+5+5, 0])
            rotate([0, 90, 0])
                wedge(height, depth-5, 5);
            
            for (i=[-1, 1])
            translate([-6.5+i*(width/2+1.5), 3*nozzle_width+608_bearing_od+3*nozzle_width+5, -height])
                cube([13, 5, height+5]);
        }
        
        for (i=[-1, 0, 1])
        translate([-1.5+i*(width/2-6.5), 3*nozzle_width+608_bearing_od+3*nozzle_width+5+depth-1.5-6*nozzle_width, -0.1])
            cube([3, 1.5, 5.2]);
        
        translate([0, 3*nozzle_width+608_bearing_od/2+(z_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2, -0.1]) {
            hull() {
                for (i=[-1, 1])
                translate([0, i*4, 0])
                    cylinder(d=nema17_cylinder_dia+play, 5+0.2, $fn=128);
            }
            
            for (i=[-1, 1])
            for (j=[-1, 1])
            translate([i*nema17_screw_distance/2, j*nema17_screw_distance/2, 0])
            hull() {
                translate([0, -4, 0])
                    cylinder(d=3+play, h=5+0.2, $fn=32);

                translate([0, 4, 0])
                    cylinder(d=3+play, h=5+0.2, $fn=32);
            }
        }
        
        translate([0, 3*nozzle_width+608_bearing_od+3*nozzle_width+5, -height/2+2.5]) {
            for (i=[-1, 1])
            for (j=[-1, 0, 1])
            translate([i*(width+7)/2, 0, j*(height+5)/3]) {
                translate([0, -0.1, 0])
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=5.2, $fn=32);
            
                translate([0, 5, 0])
                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=5, $fn=32);
            }
        }
    }
}


rotate([0, 180, 180])
translate([0, -(3*nozzle_width+608_bearing_od+3*nozzle_width+5), -5])
z_axis_motor_holder();

translate([0, 5, 0])
z_axis_fixed_bearing_block_top();

translate([0, 20, 0])
z_axis_fixed_bearing_block_base();

translate([0, 35, 0])
z_axis_floating_bearing_block_top();

translate([0, 50, 0])
z_axis_floating_bearing_block_base();

translate([50, 0, 0])
rotate([0, 0, -90])
z_axis_bearing_mount();


// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains the parts for the x-axis.

include <Measurements.scad>


module x_axis_bearing_mount() {
    width = 2*(x_axis_smooth_rod_distance/2+lm8uu_od/2+3*nozzle_width+m3_screw_head_dia+3*nozzle_width);

    difference() {
        union() {
            translate([-width/2, 0, 0])
                cube([width, 2+3*nozzle_width+608_bearing_od/2-anti_backlash_nut_height/2, lm8uu_length]);

            for (i=[0, 1])
            mirror([i, 0, 0]) {
                translate([x_axis_smooth_rod_distance/2-lm8uu_od/2-6*nozzle_width, 0, 0])
                    cube([lm8uu_od/2+6*nozzle_width+(width-x_axis_smooth_rod_distance)/2, 2+3*nozzle_width+608_bearing_od/2, 2*lm8uu_length]);
                
                hull() {
                    translate([x_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, 0])
                        cylinder(d=lm8uu_od+2*6*nozzle_width, h=2*lm8uu_length, $fn=64);

                    translate([width/2-6*nozzle_width-lm8uu_od/2, 2+3*nozzle_width+608_bearing_od/2, 0])
                        cylinder(d=lm8uu_od+2*6*nozzle_width, h=2*lm8uu_length, $fn=64);
                }

                for (j=[-1, 1])
                translate([x_axis_smooth_rod_distance/2+(width-x_axis_smooth_rod_distance+lm8uu_od)/4, 0, lm8uu_length+j*lm8uu_length/2]) {
                    rotate([-90, 0, 0])
                        cylinder(d=m3_screw_head_dia+play, h=21, $fn=32);
                }
            }

            // endstop hit point
            hull() {
                translate([(x_axis_smooth_rod_distance/2-lm8uu_od/2-6*nozzle_width), 0, 2*lm8uu_length-2])
                    cube([lm8uu_od/2+6*nozzle_width+(width-x_axis_smooth_rod_distance)/2+9.5, 2+3*nozzle_width+608_bearing_od/2-anti_backlash_nut_height/2, 2]);

                translate([(x_axis_smooth_rod_distance/2-lm8uu_od/2-6*nozzle_width), 0, 2*lm8uu_length-2-9.5])
                    cube([lm8uu_od/2+6*nozzle_width+(width-x_axis_smooth_rod_distance)/2, 2+3*nozzle_width+608_bearing_od/2-anti_backlash_nut_height/2, 6]);
            }
        }
        
        for (i=[0, 1])
        mirror([i, 0, 0]) {
            translate([x_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, -0.1])
                cylinder(d=lm8uu_od+play, h=2*lm8uu_length+0.2, $fn=64);
                
            translate([x_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, -0.1])
                cube([lm8uu_od/2+3*nozzle_width+(width-x_axis_smooth_rod_distance)/2, 1, 2*lm8uu_length+0.2]);
        
            for (j=[-1, 1])
            translate([x_axis_smooth_rod_distance/2+(width-x_axis_smooth_rod_distance+lm8uu_od)/4, -0.1, lm8uu_length+j*lm8uu_length/2]) {
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

module x_axis_floating_bearing_block_base() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+3*nozzle_width+x_axis_smooth_rod_dia/2)+x_axis_smooth_rod_distance;

    difference() {
        translate([-width/2, play/2, 0])
            cube([width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
        
        for (i=[-1, 1]) {
            translate([i*x_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=x_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);
            
            translate([i*(608_bearing_od/2+(x_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(x_axis_smooth_rod_distance/2+(width-x_axis_smooth_rod_distance+8)/4), -0.1, profile_width/2])
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

module x_axis_floating_bearing_block_top() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+3*nozzle_width+x_axis_smooth_rod_dia/2)+x_axis_smooth_rod_distance;

    difference() {
        union() {
            translate([-width/2, 0, 0])
                cube([width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
        
            difference() {
                translate([0, 3*nozzle_width+608_bearing_od/2, 0])
                    cylinder(d=608_bearing_od+8*nozzle_width, h=profile_width, $fn=64);
                
                translate([-4*nozzle_width-608_bearing_od/2-0.1, 3*nozzle_width+608_bearing_od/2-play/2, -0.1])
                    cube([8*nozzle_width+608_bearing_od+0.2, 4*nozzle_width+608_bearing_od/2+0.2, profile_width+0.2]);
            }
        }
                
        for (i=[-1, 1]) {
            translate([i*(608_bearing_od/2+(x_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
            
            translate([i*(x_axis_smooth_rod_distance/2+(width-x_axis_smooth_rod_distance+8)/4), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
        }
        
        translate([0, 3*nozzle_width+608_bearing_od/2, 0]) {
            for (i=[-1, 1])
            translate([i*x_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=x_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);

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

module x_axis_fixed_bearing_block_base() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+3*nozzle_width+x_axis_smooth_rod_dia/2)+x_axis_smooth_rod_distance;

    difference() {
        translate([-width/2, play/2, 0])
            cube([width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
        
        for (i=[-1, 1]) {
            translate([i*x_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=x_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);
            
            translate([i*(608_bearing_od/2+(x_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(width/2-6*nozzle_width-m3_screw_head_dia/2), -0.1, profile_width/2])
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

module x_axis_fixed_bearing_block_top() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+3*nozzle_width+x_axis_smooth_rod_dia/2)+x_axis_smooth_rod_distance;

    difference() {
        union() {
            translate([-width/2, 0, 0])
                cube([width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);

            difference() {
                translate([0, 3*nozzle_width+608_bearing_od/2, 0])
                    cylinder(d=608_bearing_od+8*nozzle_width, h=profile_width, $fn=64);
                
                translate([-4*nozzle_width-608_bearing_od/2-0.1, 3*nozzle_width+608_bearing_od/2-play/2, -0.1])
                    cube([8*nozzle_width+608_bearing_od+0.2, 4*nozzle_width+608_bearing_od/2+0.2, profile_width+0.2]);
            }
                
            // endstop mount
            translate([width/2, 0, 0])
                cube([6, 2*(3*nozzle_width+608_bearing_od/2), profile_width]);
        }

        // endstop mounting screws
        translate([width/2+2-play, 2*(3*nozzle_width+608_bearing_od/2), 0]) {
            translate([0, -15.5, 9])
            rotate([0, 90, 0]) {
                cylinder(d=2.5+play, h=4+0.1+play, $fn=16);
                
                hex_nut(m2_5_nut_width+play, m2_5_nut_height+play);
            }
            
            translate([0, -15.5-(m2_5_nut_width+play)/2, -0.1])
                cube([m2_5_nut_height+play, m2_5_nut_width+play, 9+0.1]);

            translate([-2, -5.5, 9])
            rotate([0, 90, 0]) {
                cylinder(d=2.5+play, h=6+0.1+play, $fn=16);
                
                hex_nut(m2_5_nut_width+play, 2+m2_5_nut_height+play);
            }
        }
        
        for (i=[-1, 1]) {
            translate([i*(608_bearing_od/2+(x_axis_smooth_rod_distance/2-608_bearing_od/2-4)/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
            
            translate([i*(width/2-6*nozzle_width-m3_screw_head_dia/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
        }
        
        translate([0, 3*nozzle_width+608_bearing_od/2, 0]) {
            for (i=[-1, 1])
            translate([i*x_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=x_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);

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

module x_axis_motor_holder() {
    width = 5+1+nema17_width+1+5;
    base_width = 6*nozzle_width+m4_screw_head_dia+6*nozzle_width+width+6*nozzle_width+m4_screw_head_dia+6*nozzle_width;
    depth = (x_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2-608_bearing_od/2-3*nozzle_width-2*profile_width+nema17_width/2+5;
    height = profile_width;
    
    difference() {
        union() {
            translate([-width/2, -nema17_width/2-5, -5])
                cube([width, depth, 5]);
            
            for (i=[-1, 1])
            translate([i*(width-5)/2-2.5, -5+depth-nema17_width/2-5, -0.1])
            rotate([0, -90, 180])
                wedge(height+0.1, depth-5, 5);
            
            translate([-base_width/2, depth-nema17_width/2-10, 0])
                cube([base_width, 5, height]);
                
            translate([-base_width/2, depth-nema17_width/2-10, -5])
                cube([base_width, 5+profile_width, 5]);
        }
        
        translate([0, 0, -5.1]) {
            hull() {
                for (i=[-1, 1])
                translate([0, i*4, 0])
                    cylinder(d=nema17_cylinder_dia+play, h=5.2, $fn=128);
            }
        
            for (i=[-1, 1])
            for (j=[-1, 1])
            translate([i*nema17_screw_distance/2, j*nema17_screw_distance/2, 0])
            hull() {
                for (k=[-1, 1])
                translate([0, k*4, 0])
                    cylinder(d=3+play, h=5.2, $fn=32);
            }
        }
        
        for (i=[-1, 1])
        translate([i*(m4_screw_head_dia/2+6*nozzle_width+width/2), 0, 0]) {
            translate([0, -0.1+depth-nema17_width/2-10, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=4+play, h=5.2, $fn=32);
            
            translate([0, depth-nema17_width/2-5+profile_width/2, -5.1])
                cylinder(d=4+play, h=5.2, $fn=32);
        }
    }
}


translate([0,0, 5])
x_axis_motor_holder();

translate([0, 55, 0])
x_axis_bearing_mount();

translate([60, 25, 0])
rotate([0, 0, 90])
x_axis_floating_bearing_block_base();

translate([75, 25, 0])
rotate([0, 0, 90])
x_axis_floating_bearing_block_top();

translate([-50, 30, 0])
rotate([0, 0, 90])
x_axis_fixed_bearing_block_top();

translate([-65, 25, 0])
rotate([0, 0, 90])
x_axis_fixed_bearing_block_base();

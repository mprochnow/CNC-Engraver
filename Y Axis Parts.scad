// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains the parts for the y-axis.

include <Measurements.scad>


module y_axis_floating_bearing_block_base() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+6*nozzle_width+y_axis_smooth_rod_dia/2)+y_axis_smooth_rod_distance;

    difference() {
        translate([-width/2, play/2, 0])
            cube([width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
        
        for (i=[-1, 1]) {
            translate([i*y_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=y_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);
            
            translate([i*(608_bearing_od/2+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(y_axis_smooth_rod_distance/2+4+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

            translate([i*(y_axis_smooth_rod_distance/2-4-6*nozzle_width-m3_screw_head_dia/2), -0.1, profile_width/2])
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

module y_axis_floating_bearing_block_top() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+6*nozzle_width+y_axis_smooth_rod_dia/2)+y_axis_smooth_rod_distance;

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
        
        // endstop mount
        translate([608_bearing_od/2+(y_axis_smooth_rod_distance/2-4-608_bearing_od/2)/2, 0, 0]) {
            translate([-10.5, -0.1, -0.1])
                cube([21, 6+m2_5_panhead_screw_height+play+0.1, profile_width+0.2]);
            
            for (i=[-1, 1])
            translate([i*5, -0.1, 9])
            rotate([-90, 0, 0]) {
                cylinder(d=2.5+play, h=20, $fn=16);
                
                translate([0, 0, 6+m2_5_panhead_screw_height+play+2])
                rotate([0, 0, 30])
                    hex_nut(m2_5_nut_width, 10);
            }
        }
        
        for (i=[-1, 1]) {
            translate([i*(608_bearing_od/2+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
            
            translate([i*(y_axis_smooth_rod_distance/2+4+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }

            translate([i*(y_axis_smooth_rod_distance/2-4-6*nozzle_width-m3_screw_head_dia/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
        }
        
        translate([0, 3*nozzle_width+608_bearing_od/2, 0]) {
            for (i=[-1, 1])
            translate([i*y_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=y_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);

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

module y_axis_fixed_bearing_block_base() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+6*nozzle_width+y_axis_smooth_rod_dia/2)+y_axis_smooth_rod_distance;

    difference() {
        translate([-width/2, play/2, 0])
            cube([width, 3*nozzle_width+608_bearing_od/2-play/2, profile_width]);
        
        for (i=[-1, 1]) {
            translate([i*y_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=y_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);
            
            translate([i*(608_bearing_od/2+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);
            
            translate([i*(y_axis_smooth_rod_distance/2+4+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2])
            rotate([-90, 0, 0])
                cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

            translate([i*(y_axis_smooth_rod_distance/2-4-6*nozzle_width-m3_screw_head_dia/2), -0.1, profile_width/2])
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

module y_axis_fixed_bearing_block_top() {
    width = 2*(6*nozzle_width+m3_screw_head_dia+6*nozzle_width+y_axis_smooth_rod_dia/2)+y_axis_smooth_rod_distance;

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
            translate([i*(608_bearing_od/2+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
            
            translate([i*(y_axis_smooth_rod_distance/2+4+6*nozzle_width+m3_screw_head_dia/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }

            translate([i*(y_axis_smooth_rod_distance/2-4-6*nozzle_width-m3_screw_head_dia/2), -0.1, profile_width/2]) {
                rotate([-90, 0, 0])
                    cylinder(d=3+play, h=3*nozzle_width+608_bearing_od/2+0.2, $fn=32);

                rotate([-90, 0, 0])
                    cylinder(d=m3_screw_head_dia+play, h=m3_screw_head_height+1.4+0.1, $fn=32);
            }
        }
        
        translate([0, 3*nozzle_width+608_bearing_od/2, 0]) {
            for (i=[-1, 1])
            translate([i*y_axis_smooth_rod_distance/2, 0, -0.1])
                cylinder(d=y_axis_smooth_rod_dia+play, h=profile_width+0.2, $fn=32);

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

module y_axis_bearing_mount() {
    width = 2*(y_axis_smooth_rod_distance/2+lm8uu_od/2+3*nozzle_width+m4_screw_head_dia+3*nozzle_width);
    height = 2*lm8uu_length+y_axis_lm8uu_distance;

    difference() {
        union() {
            translate([-width/2, 0, 0])
                cube([width, 2+3*nozzle_width+608_bearing_od/2-anti_backlash_nut_height/2, lm8uu_length+y_axis_lm8uu_distance]);

            for (i=[0, 1])
            mirror([i, 0, 0]) {
                translate([y_axis_smooth_rod_distance/2-lm8uu_od/2-6*nozzle_width, 0, 0])
                    cube([lm8uu_od/2+6*nozzle_width+(width-y_axis_smooth_rod_distance)/2, 2+3*nozzle_width+608_bearing_od/2, height]);
                
                hull() {
                    translate([y_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, 0])
                        cylinder(d=lm8uu_od+2*6*nozzle_width, h=height, $fn=64);

                    translate([width/2-6*nozzle_width-lm8uu_od/2, 2+3*nozzle_width+608_bearing_od/2, 0])
                        cylinder(d=lm8uu_od+2*6*nozzle_width, h=height, $fn=64);
                }
            }
        }
        
        for (i=[0, 1])
        mirror([i, 0, 0]) {
            translate([y_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2, 0]) {
                translate([0, 0, -0.1])
                    cylinder(d=lm8uu_od-2, h=height+0.2, $fn=64);
                
                translate([0, 0, lm8uu_length])
                    cylinder(d1=lm8uu_od, d2=lm8uu_od-2, h=1, $fn=64);

                translate([0, 0, height-lm8uu_length-1])
                    cylinder(d1=lm8uu_od-2, d2=lm8uu_od, h=1, $fn=64);

                for (i=[-0.1, height-lm8uu_length])
                translate([0, 0, i])
                    cylinder(d=lm8uu_od+play, h=lm8uu_length+0.1, $fn=64);
            }
        
            translate([y_axis_smooth_rod_distance/2, 2+3*nozzle_width+608_bearing_od/2-3, -0.1])
                cube([lm8uu_od/2+3*nozzle_width+(width-y_axis_smooth_rod_distance)/2, 1, height+0.2]);

            for (i=[-1, 0, 1])
            translate([y_axis_smooth_rod_distance/2+(width-y_axis_smooth_rod_distance+lm8uu_od)/4, -0.1, height/2+i*30]) {
                rotate([-90, 0, 0])
                    cylinder(d=4+play, h=2+3*nozzle_width+608_bearing_od/2+lm8uu_od/2+3*nozzle_width+0.2, $fn=32);
                
                translate([0, 16, 0])
                rotate([-90, 0, 0])
                    cylinder(d=m4_screw_head_dia+play, h=20, $fn=32);
            }
        }
        
        for (i=[-1, 1])
        translate([i*anti_backlash_nut_screw_distance/2, -0.1, height/2])
        rotate([-90, 0, 0])
            cylinder(d=anti_backlash_nut_screw_dia+play, h=2+3*nozzle_width+608_bearing_od/2, $fn=32);
    }
}

module y_axis_motor_mount() {
    d = 5+nema17_shaft_length;

    difference() {
        union() {
            translate([-nema17_width/2, 0, -nema17_width/2])
                cube([nema17_width, 5, nema17_width]);
            
            translate([-nema17_width/2-5, 0, -nema17_width/2-3])
                cube([5, d, nema17_width+3]);
            
            translate([nema17_width/2, 0, -nema17_width/2-3])
                cube([5, d, nema17_width/2+3]);
            
            translate([-nema17_width/2, 0, -nema17_width/2-3])
                cube([nema17_width, d, 5]);
            
            translate([-nema17_width/2-5-10, d-5, -nema17_width/2-3])
                cube([10, 5, nema17_width+3]);
                
            translate([nema17_width/2+5, d-5, -nema17_width/2-3])
                cube([10, 5, nema17_width/2+3]);
                
            translate([-nema17_width/2-5, d-5, -nema17_width/2-3])
            rotate([0, 0, 180])
                wedge(10, d-5, nema17_width+3);
                
            translate([nema17_width/2+5, d-5, 0.001])
            rotate([180, 0, 0])
                wedge(10, d-5, nema17_width/2+3+0.001);
        }
        
        translate([0, -0.1, 0])
        rotate([-90, 0, 0]) {
            cylinder(d=nema17_cylinder_dia+play, h=5+0.2, $fn=128);
            
            translate([-nema17_cylinder_dia/2, -nema17_width, 0])
                cube([nema17_width, nema17_width, 5+0.2]);
            
            translate([0, -nema17_width, 0])
                cube([nema17_width, nema17_width, 5+0.2]);

            for (i=[-1, 1])
            for (j=[-1, 1]) {
                translate([i*nema17_screw_distance/2, j*nema17_screw_distance/2, 0])
                    cylinder(d=3+play, h=5+0.2, $fn=32);
                
                translate([i*(5+5+nema17_width+5+5)/2, 5+j*20/2, d-4.4])
                    cylinder(d=4+play, h=5, $fn=32);

                translate([i*(5+5+nema17_width+5+5)/2, 5+j*20/2, -5])
                    cylinder(d=m4_screw_head_dia+play, h=d, $fn=32);
            }
        }
    }
}


translate([0, -30, 0])
rotate([90, 0, 0])
    y_axis_motor_mount();

y_axis_floating_bearing_block_top();

translate([0, 20, 0])
y_axis_floating_bearing_block_base();

translate([0, 40, 0])
y_axis_fixed_bearing_block_top();

translate([0, 60, 0])
y_axis_fixed_bearing_block_base();

translate([0, 80, 0])
y_axis_bearing_mount();

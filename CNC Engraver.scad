// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains a model of the complete assembly.

include <Measurements.scad>
use <X Axis Parts.scad>
use <Y Axis Parts.scad>
use <Z Axis Parts.scad>
use <Dust Shoe.scad>


module stepper_nema17() {
	color("darkgrey")
	union() {
		stepper_mount(stepper_motor_length);
		translate([nema17_width/2, nema17_width/2, 0])
		union() {
			cylinder(d=nema17_cylinder_dia, stepper_motor_length+2, $fn=32);
			cylinder(d=5, stepper_motor_length+nema17_shaft_length, $fn=16);
		}
	}
}

module bearing_608() {
	color("slategrey")
	linear_extrude(7)
	difference() {
		circle(d=22, $fn=32);
		circle(d=8, $fn=16);
	}
}

module anti_backlash_nut() {
	color("darkslategrey")
	difference() {
		linear_extrude(anti_backlash_nut_height, convexity=3)
		difference() {
			square([anti_backlash_nut_width, anti_backlash_nut_depth]);

			translate([anti_backlash_nut_width-23.5, 8])
				square([23.5, 5]);

			for (i=[-1, 1])
			translate([anti_backlash_nut_width/2+i*anti_backlash_nut_screw_distance/2, anti_backlash_nut_depth+anti_backlash_nut_screw_offset, 0])
				circle(d=anti_backlash_nut_screw_dia, $fn=16);
		}

		translate([0, 0, anti_backlash_nut_height/2])
		rotate([-90, 0, 0])
		translate([anti_backlash_nut_width/2, 0, -0.1])
			cylinder(d=8, h=anti_backlash_nut_depth+0.2, $fn=16);

		for (i=[-1, 1])
		translate([anti_backlash_nut_width/2+i*anti_backlash_nut_screw_distance/2, anti_backlash_nut_depth+anti_backlash_nut_screw_offset, -0.1])
			cylinder(d=9, h=3.1, $fn=16);

		translate([anti_backlash_nut_width/2+10, -0.1, anti_backlash_nut_height/2])
		rotate([-90, 0, 0])
			cylinder(d=5, h=8.2, $fn=16);
	}
}

module gt2_pulley_20t() {
    color("lightgrey") {
        cylinder(d=16, h=7.5, $fn=16);
        cylinder(d=12, h=16, $fn=16);
        translate([0, 0, 16-1.3])
            cylinder(d=16, h=1.3, $fn=16);
    }
}

module profile_2020(length) {
	color("lightgrey")
	linear_extrude(length)
	difference() {
		square(20, 20);

		translate([10, 10])
			circle(d=4.3, $fn=16);

		translate([10, 10])
		for (a=[0, 90, 180, 270])
		rotate([0, 0, a])
		translate([-5/2, 10-6.35])
			square([5, 6.35]);
	}
}

module profile_2040(length) {
	profile_2020(length);
	translate([20, 0 ,0])
		profile_2020(length);
}

module base() {
    module x_carriage_assembly() {
        translate([0, sk20_rail_mount_offset+5+2, -sk20_depth]) {
            translate([0, 3*nozzle_width+608_bearing_od/2, 0]) {
                for (i=[-1, 1])
                translate([i*z_axis_smooth_rod_distance/2, 0, -0.1])
                color("grey")
                    cylinder(d=z_axis_smooth_rod_dia, h=z_axis_smooth_rod_length+0.2, $fn=16);

                for (i=[profile_width/2-608_bearing_height/2, z_axis_smooth_rod_length-profile_width, z_axis_smooth_rod_length-608_bearing_height])
                translate([0, 0, i])
                    bearing_608();

                translate([0, 0, z_axis_smooth_rod_length-profile_width-8mm_collar_height])
                color("grey")
                    cylinder(d=8mm_collar_dia, h=8mm_collar_height, $fn=16);

                translate([0, 0, -0.1])
                color("darkgoldenrod")
                    cylinder(d=8, h=z_axis_smooth_rod_length+m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height+0.2, $fn=16);
                
                echo("z-axis threaded rod length", z_axis_smooth_rod_length+m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height);

                translate([0, 0, z_axis_smooth_rod_length]) {
                    color("grey")
                        cylinder(d=m8_washer_od, h=m8_washer_height, $fn=16);

                    translate([0, 0, m8_washer_height])
                        gt2_pulley_20t();

                    translate([0, 0, m8_washer_height+gt2_pulley_20t_height])
                    color("grey")
                        hex_nut(m8_nut_width, m8_flat_nut_height);
                }
            }

            translate([-z_axis_base_width/2, 3*nozzle_width+608_bearing_od+3*nozzle_width, 0])
            color("lightgrey")
                cube([z_axis_base_width, 5, z_axis_smooth_rod_length]);
            
            echo("z-axis base plate w, d, h", z_axis_base_width, z_axis_smooth_rod_length, 5);

            translate([0, 3*nozzle_width+608_bearing_od+3*nozzle_width+5+2+3*nozzle_width+608_bearing_od/2, x_axis_smooth_rod_distance/2+lm8uu_od/2+3*nozzle_width+m3_screw_head_dia+3*nozzle_width]) {
                rotate([90, 90, 0])
                translate([-anti_backlash_nut_width/2, -anti_backlash_nut_depth/2, -anti_backlash_nut_height/2])
                    anti_backlash_nut();

                for (i=[-1, 1])
                for (j=[-1, 1])
                translate([i*(lm8uu_length+0.2)/2, 0, j*x_axis_smooth_rod_distance/2])
                rotate([0, 90, 0])
                translate([0, 0, -lm8uu_length/2])
                color("slategrey")
                    cylinder(d=lm8uu_od, h=lm8uu_length+0.2, $fn=32);
            }

            translate([0, 3*nozzle_width+608_bearing_od/2+(z_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2, z_axis_smooth_rod_length-5]) {
                translate([-nema17_width/2, -nema17_width/2, -stepper_motor_length])
                    stepper_nema17();

                translate([0, 0, 5+m8_washer_height])
                    gt2_pulley_20t();
            }

            translate([0, 608_bearing_od/2+3*nozzle_width, 0])
            color("blue")
                z_axis_floating_bearing_block_base();

            translate([0, -0.1, 0])
            color("blue")
                z_axis_floating_bearing_block_top();

            translate([0, 0, z_axis_smooth_rod_length-profile_width]) {
                color("blue")
                translate([0, 608_bearing_od/2+3*nozzle_width, 0])
                    z_axis_fixed_bearing_block_base();

                translate([0, -0.1, 0])
                color("blue")
                    z_axis_fixed_bearing_block_top();
            }

            translate([0, 0, z_axis_smooth_rod_length-5])
            color("blue")
                z_axis_motor_holder();

            translate([0, 3*nozzle_width+608_bearing_od+3*nozzle_width+5, x_axis_smooth_rod_distance/2+lm8uu_od/2+3*nozzle_width+m3_screw_head_dia+3*nozzle_width])
            color("blue")
            rotate([0, -90, 0])
            translate([0, 0, -lm8uu_length])
                x_axis_bearing_mount();
        }
    }

    module z_carriage_assembly() {
        translate([0, sk20_rail_mount_offset+5+2+3*nozzle_width+608_bearing_od/2, profile_width+lm8uu_length-sk20_depth]) {
            rotate([-90, 0, 180])
            translate([-anti_backlash_nut_width/2, -anti_backlash_nut_depth/2, -anti_backlash_nut_height/2])
                anti_backlash_nut();

            for (i=[-1, 1])
            for (j=[-1, 0])
            translate([i*z_axis_smooth_rod_distance/2, 0, j*lm8uu_length-0.1])
            color("slategrey")
                cylinder(d=lm8uu_od, h=lm8uu_length+0.2, $fn=32);
        }

        translate([-z_axis_base_width/2, sk20_rail_mount_offset, -sk20_depth])
        color("lightgrey")
            cube([z_axis_base_width, 5, z_axis_carriage_height]);
        
        echo("z-axis carriage plate w, d, h", z_axis_base_width, z_axis_carriage_height, 5);

        translate([0, sk20_rail_mount_offset+5, profile_width-sk20_depth])
        color("blue")
            z_axis_bearing_mount();

        translate([0, sk20_rail_mount_offset, -sk20_depth/2])
        rotate([90, 0, 0])
            sk20();

        translate([0, -dust_shoe_depth+16, -dust_shoe_height+4*nozzle_width])
        color("blue")
            dust_shoe();
    }

    module x_axis() {
        translate([0, y_axis_smooth_rod_length/2, z_axis_vertical_offset]) {
            translate([0, sk20_rail_mount_offset+5+2+3*nozzle_width+608_bearing_od+3*nozzle_width+5+2+3*nozzle_width+608_bearing_od/2, 0]) {
                translate([0, 0, -sk20_depth+x_axis_smooth_rod_distance/2+lm8uu_od/2+3*nozzle_width+m3_screw_head_dia+3*nozzle_width]) {
                    for (i=[-1, 1])
                    translate([-0.1, 0, i*x_axis_smooth_rod_distance/2])
                    rotate([0, 90, 0])
                    color("grey")
                        cylinder(d=x_axis_smooth_rod_dia, h=x_axis_smooth_rod_length+0.2, $fn=16);

                    translate([-(m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height+0.1), 0, 0])
                    rotate([0, 90, 0])
                    color("darkgoldenrod")
                        cylinder(d=8, h=x_axis_smooth_rod_length+m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height+0.1, $fn=16);
                    
                    echo("x-axis threaded rod length", x_axis_smooth_rod_length+m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height);

                    for (i=[0, profile_width-608_bearing_height, x_axis_smooth_rod_length-profile_width/2-608_bearing_height/2])
                    translate([i, 0, 0])
                    rotate([0, 90 ,0])
                        bearing_608();

                    rotate([0, -90, 0])
                    color("grey")
                        cylinder(d=m8_washer_od, h=m8_washer_height, $fn=16);

                    translate([-m8_washer_height, 0, 0])
                    rotate([0, -90, 0])
                    color("grey")
                        hex_nut(m8_nut_width, m8_flat_nut_height);

                    translate([-(m8_washer_height+m8_flat_nut_height), 0, 0])
                    rotate([0, -90, 0])
                    color("lightgrey")
                        gt2_pulley_20t();

                    translate([profile_width, 0, 0])
                    rotate([0, 90, 0])
                    color("grey")
                        cylinder(d=8mm_collar_dia, h=8mm_collar_height, $fn=16);
                        
                    translate([0, (x_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2, 0])
                    rotate([0, -90, 0]) {
                        translate([-nema17_width/2, -nema17_width/2, -stepper_motor_length])
                            stepper_nema17();

                        translate([0, 0, m8_washer_height+m8_flat_nut_height])
                            gt2_pulley_20t();
                    }

                    rotate([0, 90, 0])
                    color("blue")
                        x_axis_fixed_bearing_block_base();

                    translate([profile_width, -(3*nozzle_width+608_bearing_od/2+0.1), 0])
                    rotate([0, -90, 0])
                    color("blue")
                        x_axis_fixed_bearing_block_top();

                    translate([x_axis_smooth_rod_length-profile_width, 0, 0]) {
                        rotate([0, 90, 0])
                        color("blue")
                            x_axis_floating_bearing_block_base();

                        translate([0, -(3*nozzle_width+608_bearing_od/2+0.1), 0])
                        rotate([0, 90, 0])
                        color("blue")
                            x_axis_floating_bearing_block_top();
                    }
                    
                    translate([0, (x_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2, 0])
                    rotate([180, -90, 0])
                    color("blue")
                        x_axis_motor_holder();
                }

                translate([0, 608_bearing_od/2+3*nozzle_width, -z_axis_vertical_offset]) {
                    for(i=[0, x_axis_smooth_rod_length-profile_width])
                    translate([profile_width+i, 0, 0])
                    rotate([0, 0, 90])
                        profile_2040(portal_height);
                    
                    echo("x-axis long profile length", portal_height);

                    translate([profile_width, profile_width, portal_height])
                    rotate([0, 90, 0])
                        profile_2040(x_axis_smooth_rod_length-2*profile_width);
                    
                    echo("x-axis short profile length", x_axis_smooth_rod_length-2*profile_width);
                }
            }
        }
        
        echo("portal offset", y_axis_smooth_rod_length/2+sk20_rail_mount_offset+5+2+3*nozzle_width+608_bearing_od+3*nozzle_width+5+2+3*nozzle_width+608_bearing_od/2+608_bearing_od/2+3*nozzle_width);
    }

	module y_axis() {
        translate([profile_width, 0, 0]){
            for (i=[profile_width, x_axis_smooth_rod_length-2*profile_width])
            translate([i, 0, 2*profile_width])
            rotate([0, 90, 90])
                profile_2040(base_depth);
            
            echo("y-axis long profile length", base_depth);

            for (i=[0, y_axis_smooth_rod_length-profile_width])
            translate([profile_width, i, 2*profile_width])
            rotate([0, 90, 0])
                profile_2040(x_axis_smooth_rod_length-2*2*profile_width);
            
            echo("y-axis short profile length", x_axis_smooth_rod_length-2*2*profile_width);

            translate([(x_axis_smooth_rod_length-2*profile_width)/2, 0, 2*profile_width+608_bearing_outer_dia/2+3*nozzle_width]) {
                translate([0, -0.1, 0])
                rotate([-90, 0, 0])
                color("darkgoldenrod")
                    cylinder(d=8, h=y_axis_smooth_rod_length+m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height+0.2, $fn=16);
                
                echo("y-axis threaded rod length", y_axis_smooth_rod_length+m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height);
                echo("y-axis m8 thread length",m8_washer_height+gt2_pulley_20t_height+m8_flat_nut_height);

                for (i=[-1, 1])
                translate([i*y_axis_smooth_rod_distance/2, -0.1, 0])
                rotate([-90, 0, 0])
                color("grey")
                    cylinder(d=y_axis_smooth_rod_dia, h=y_axis_smooth_rod_length+0.2, $fn=16);

                translate([0, profile_width/2-608_bearing_height/2, 0])
                rotate([-90, 0, 0])
                    bearing_608();

                translate([0, y_axis_smooth_rod_length, 0])
                union() {
                    translate([0, -profile_width, 0])
                    translate([0, 608_bearing_height, 0])
                    rotate([90, 0, 0])
                        bearing_608();

                    rotate([90, 0, 0])
                        bearing_608();

                    translate([0, -profile_width, 0])
                    rotate([90, 0, 0])
                    color("grey")
                        cylinder(d=8mm_collar_dia, h=8mm_collar_height, $fn=16);
                        
                    rotate([-90, 0, 0])
                    color("grey")
                        cylinder(d=m8_washer_od, h=m8_washer_height, $fn=16);

                    translate([0, m8_washer_height, 0])
                    rotate([-90, 0, 0])
                        gt2_pulley_20t();

                    translate([0, m8_washer_height+gt2_pulley_20t_height, 0])
                    rotate([-90, 0, 0])
                    color("grey")
                        hex_nut(m8_nut_width, m8_flat_nut_height);
                }
                
                rotate([-90, 0, 0])
                color("blue")
                    y_axis_floating_bearing_block_base();
                
                translate([0, profile_width, 3*nozzle_width+608_bearing_od/2+0.1])
                rotate([-90, 0, 180])
                color("blue")
                    y_axis_floating_bearing_block_top();
                    
                translate([0, y_axis_smooth_rod_length-profile_width, 0])
                rotate([-90, 0, 0])
                color("blue")
                    y_axis_fixed_bearing_block_base();
                    
                translate([0, y_axis_smooth_rod_length-profile_width, 3*nozzle_width+608_bearing_od/2+0.1])
                rotate([-90, 0, 0])
                color("blue")
                    y_axis_fixed_bearing_block_top();
            }

            c = (y_axis_motor_belt_length-PI*gt2_pulley_20t_teeth_dia)/2-2;
            b = 608_bearing_od/2+3*nozzle_width+2*profile_width-5-nema17_width/2;
            a = sqrt(pow(c, 2)-pow(b, 2));
            
            translate([(x_axis_smooth_rod_length-2*profile_width)/2+a, y_axis_smooth_rod_length+5+nema17_shaft_length, profile_width+5]) {
                rotate([90, 0, 0]) {
                    translate([-nema17_width/2, -nema17_width/2, -stepper_motor_length])
                        stepper_nema17();

                    translate([0, 0, 5+nema17_shaft_length-16-m8_washer_height-7.5])
                        gt2_pulley_20t();
                }
                
                rotate([0, 0, 180])
                color("blue")
                    y_axis_motor_mount();
            }
        }
    }

	module table() {
        translate([-table_width/2, -table_depth/2, 608_bearing_outer_dia+2*3*nozzle_width+2])
        color("lightgrey")
        difference() {
            cube([table_width, table_depth, table_height]);
        
            for (i=[15, 45, 75, 105]) {
                translate([-0.1, -4+i, table_height/3*2])
                    cube([table_width+0.2, 8, table_height/3+0.1]);
            }

            for (i=[30, 60, 90]) {
                translate([-0.1, -4+i, -0.1])
                    cube([table_width+0.2, 8, table_height/3+0.1]);
            }
        }

		translate([0, 0, 608_bearing_outer_dia/2+3*nozzle_width]) {
			for (i=[-1, 1])
			for (j=[-1, 1])
			translate([i*y_axis_smooth_rod_distance/2, -lm8uu_length/2+j*y_axis_lm8uu_distance, 0])
			rotate([-90, 0, 0])
			color("slategrey")
				cylinder(d=lm8uu_od, h=lm8uu_length, $fn=32);

            rotate([0, 0, 180])
			translate([-anti_backlash_nut_width/2, -anti_backlash_nut_depth-anti_backlash_nut_screw_offset, -anti_backlash_nut_height/2])
				anti_backlash_nut();
		}
        
        translate([0, -lm8uu_length-y_axis_lm8uu_distance-anti_backlash_nut_screw_offset, 3*nozzle_width+608_bearing_od+3*nozzle_width+2])
        rotate([-90, 0, 0])
        color("blue")
            y_axis_bearing_mount();
	}

    y_axis();
    x_axis();

	translate([0, 0, 0])
	translate([profile_width+(x_axis_smooth_rod_length-2*profile_width)/2, y_axis_smooth_rod_length/2, 2*profile_width])
		table();

    translate([-0, 0, 0]) {
        translate([x_axis_smooth_rod_length/2, y_axis_smooth_rod_length/2, 0]) {
            translate([0, 0, z_axis_vertical_offset])
                x_carriage_assembly();

            translate([0, 0, 00]) {
                translate([0, 0, z_axis_vertical_offset]) {
                    z_carriage_assembly();
                    micromot_50();
                    //laser_module();
                }
            }
        }
    }
}

base();

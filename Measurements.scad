// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// Changing the values in this file results in changes to the parts.

include <Constants.scad>


nozzle_width = 0.4;
play = 0.2;

profile_width = 20;

x_axis_smooth_rod_length = 250;
x_axis_smooth_rod_dia = 8;
y_axis_smooth_rod_length = 210;
y_axis_smooth_rod_dia = 8;
z_axis_smooth_rod_length = 150;
z_axis_smooth_rod_dia = 8;

x_axis_smooth_rod_distance = 3 * profile_width;
y_axis_smooth_rod_distance = 120;
z_axis_smooth_rod_distance = 60;

x_axis_motor_belt_length = 200;
y_axis_motor_belt_length = 144;
z_axis_motor_belt_length = 122;

stepper_motor_length = 40;
stepper_motor_overall_length = stepper_motor_length + nema17_shaft_length;
stepper_adapter_height = 50;
stepper_adapter_screw_mount_height = 5;

table_width = 200;
table_depth = 120;
table_height = 15;

tool_offset = 44;

y_axis_lm8uu_distance = 20;

z_axis_vertical_offset = 2 * profile_width +
                         3 * nozzle_width + 608_bearing_od + 3 * nozzle_width +
                         2 +
                         table_height +
                         tool_offset;

z_axis_base_width = 90;
z_axis_carriage_height = profile_width + 2 * lm8uu_length;

portal_height = 200;
base_depth = 300;

hose_od = 26;

dust_show_opening_height = tool_offset - sk20_depth - 5 - 2*4*nozzle_width;
dust_shoe_width = 4 * nozzle_width + 30.7 + play + 4 * nozzle_width;
dust_shoe_depth = 35 + 6 * nozzle_width + hose_od + 6 * nozzle_width - play;
dust_shoe_height = 4 * nozzle_width + dust_show_opening_height + 4 * nozzle_width + 20 + play/2 + 4 * nozzle_width;

arduino_case_wall_thickness = 6 * nozzle_width;
arduino_case_standoff_height = 2.5;
arduino_case_pcb_clearance = arduino_case_wall_thickness + 1;
arduino_case_width = arduino_case_wall_thickness + 16 + arduino_uno_pcb_width + arduino_case_pcb_clearance + arduino_case_wall_thickness;
arduino_case_depth = arduino_case_wall_thickness + 23 + arduino_uno_pcb_length - arduino_uno_usb_plug_x_offset;
arduino_case_height = arduino_case_wall_thickness + arduino_case_standoff_height + arduino_uno_cnc_shield_stepper_driver_height + 8;

/// utility modules ////////////////////////////////////////////////
module hex_nut(width, height, center=false) {
    cylinder(r=(width/sin(60)/2), h=height, center=center, $fn=6);
}

module endstop_pcb(screw1=true, screw2=true) {
    pcb_width = 41;
    pcb_depth = 16.5;
    pcb_height = 1.6;

    translate([0, 0, -pcb_height])
    union() {
        cube([pcb_width, pcb_depth, pcb_height+10]);

        // placeholder for micro-switch pins
        translate([6.2, 6.5, -2])
            cube([13.5, 5, 2.1]);

        // placeholder for connector pins
        translate([26.7, 3, -2])
            cube([3, pcb_depth-6, 2.1]);
    }

    translate([0, 2.75, -8])
    union() {
        if (screw1) {
            translate([3.7, 0, 0])
                cylinder(d=3+play, h=8.5, $fn=32);
        }

        if (screw2) {
            translate([22.7, 0, 0])
                cylinder(d=3+play, h=8.5, $fn=32);
        }
    }
}

module stepper_mount(height=5) {
    width=nema17_width;

    intersection() {
        cube([width, width, height]);

        translate([width/2, width/2, -0.1])
            cylinder(r=27, h=height+0.2, $fn=256);
    }
}

module cylinder_cutout(diameter, height, top_corner_radius=0, bottom_corner_radius=0, fn=64, corner_fn=32) {
    union() {
        if (top_corner_radius) {
            translate([0, 0, height-top_corner_radius])
            difference() {
                cylinder(d=diameter+2*top_corner_radius, h=top_corner_radius+0.1, $fn=fn);

                translate([0, 0, 0.1])
                rotate_extrude($fn=fn)
                translate([diameter/2+top_corner_radius, 0, 0])
                    circle(r=top_corner_radius, $fn=32);
            }
        }

        translate([0, 0, bottom_corner_radius-0.1])
            cylinder(d=diameter, h=height-top_corner_radius-bottom_corner_radius+0.2, $fn=fn);

        if (bottom_corner_radius) {
            translate([0, 0, -0.1])
            difference() {
                cylinder(d=diameter+2*bottom_corner_radius, h=bottom_corner_radius+0.1, $fn=fn);

                translate([0, 0, bottom_corner_radius])
                rotate_extrude($fn=fn)
                translate([diameter/2+bottom_corner_radius, 0, 0])
                    circle(r=bottom_corner_radius, $fn=corner_fn);
            }
        }
    }
}

module wedge(a, b, height) {
    difference() {
        cube([a, b, height]);

        translate([0, b, 0])
        rotate([0, 0, -(90-atan(a/b))])
        translate([-1, 0, -1])
            cube([sqrt(pow(a,2)+pow(b,2))+2, b, height+2]);
    }
}

module micromot_50() {
    translate([0, 0, 30+25])
    color("DarkGreen")
        cylinder(d=34.2, h=80, $fn=32);

    translate([0, 0, 30])
    color("DarkGreen")
        cylinder(d1=21, d2=34.2, h=25);

    translate([0, 0, 0])
    color("Black")
        cylinder(d=21.2, h=30, $fn=32);

    translate([0, 0, -micromot_mount_height])
    color("Silver")
        cylinder(d=micromot_mount_dia, h=micromot_mount_height, $fn=32);

    translate([0, 0, -micromot_mount_height-7])
    union() {
        color("Silver")
            cylinder(d1=15, d2=20, h=7, $fn=32);

        translate([0, 0, -12])
        union() {
            color("Black")
                cylinder(d=10, h=12, $fn=32);

            translate([0, 0, -15])
            color("Silver")
                cylinder(d=3, h=15, $fn=16);
        }
    }
}

module laser_module() {
    translate([-15, -15, 0])
    color("black")
        cube([30, 30, 45]);
    
    translate([0, 0, -10])
    color("black")
        cylinder(d=15, h=10, $fn=16);
}

module sk20() {
	color("lightgrey")
    difference() {
        union() {
            translate([-30, -10, 0])
                cube([60, 20, 10]);
            
            translate([-15, -10, 0])
                cube([30, 20, 51]);
        }
    
        for (i=[-1, 1])
        translate([i*22.5, 0, -0.1])
            cylinder(d=6, h=10.2, $fn=16);
        
        translate([0, -10.1, 31])
        rotate([-90, 0, 0])
            cylinder(d=20, h=20.2, $fn=32);
        
        translate([-1, -10.1, 31])
            cube([2, 20.2, 20.1]);
        
        translate([0, 0, 45])
        rotate([0, 90, 0])
            cylinder(d=6, h=15.1, $fn=16);
    }
}

module arduino_uno() {
    linear_extrude(arduino_uno_pcb_height) {
        difference() {
            polygon([[0, 0],
                     [arduino_uno_pcb_length-2.54, 0],
                     [arduino_uno_pcb_length-2.54, 1.27],
                     [arduino_uno_pcb_length, 3.81],
                     [arduino_uno_pcb_length, 38.1],
                     [arduino_uno_pcb_length-2.54, 40.64],
                     [arduino_uno_pcb_length-2.54, 50.8],
                     [arduino_uno_pcb_length-5.08, arduino_uno_pcb_width],
                     [0, arduino_uno_pcb_width]]);
            
            for (p=arduino_uno_mounting_holes) {
                translate([p[0], p[1]])
                    circle(d=3.2, h=arduino_uno_pcb_height, $fn=16);
            }
        }
    }
}
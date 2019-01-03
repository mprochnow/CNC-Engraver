// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains the file for the dust shoe. The dust show is
// designed specifically for my DIY vacuum.

include <Measurements.scad>


wall_thickness = 6 * nozzle_width;
t = wall_thickness;

hose_od = 26;
hose_id = 20;
mounting_hole_depth = 18;

magnet_dia = 5;
magnet_length = 8.5;


module dust_shoe() {
    difference() {
        union() {
            translate([-dust_shoe_width/2, 0, 0])
                cube([dust_shoe_width, dust_shoe_depth, dust_shoe_height]);

            translate([-dust_shoe_width/2-1, 6*nozzle_width+hose_od+6*nozzle_width, 4*nozzle_width+dust_show_opening_height+4*nozzle_width+10-(4*nozzle_width+6+4*nozzle_width)/2])
                cube([1.1, dust_shoe_depth-(6*nozzle_width+hose_od+6*nozzle_width), 4*nozzle_width+6+4*nozzle_width]);

            translate([-dust_shoe_width/2, 6*nozzle_width+hose_od+6*nozzle_width, 4*nozzle_width+dust_show_opening_height+4*nozzle_width+10-(4*nozzle_width+6+4*nozzle_width)/2])
            rotate([0, 0, 180])
                wedge(1, 2, 4*nozzle_width+6+4*nozzle_width);

        }

        translate([-24/2, 6*nozzle_width+hose_od+6*nozzle_width+8.4, dust_shoe_height-4*nozzle_width-0.1])
            cube([24, dust_shoe_depth, 4*nozzle_width+0.2]);

        translate([-20/2, 6*nozzle_width+hose_od+6*nozzle_width+8.4, 4*nozzle_width+dust_show_opening_height-0.1])
            cube([20, dust_shoe_depth, 4*nozzle_width+0.2]);

        translate([-(dust_shoe_width-2*4*nozzle_width)/2, 6*nozzle_width+hose_od+6*nozzle_width-play, 4*nozzle_width+dust_show_opening_height+4*nozzle_width])
            cube([dust_shoe_width-2*4*nozzle_width, dust_shoe_depth, dust_shoe_height-4*nozzle_width-dust_show_opening_height-4*nozzle_width-4*nozzle_width]);

        translate([-dust_shoe_width/2+4*nozzle_width-1, 6*nozzle_width+hose_od+6*nozzle_width-play, 4*nozzle_width+dust_show_opening_height+4*nozzle_width+10-3])
            cube([1.1, dust_shoe_depth, 6]);

        hull() {
            translate([0, 6*nozzle_width+hose_od/2, 4*nozzle_width])
                cylinder(d=hose_id, h=dust_show_opening_height, $fn=64);

            translate([-dust_shoe_width/2+4*nozzle_width, 6*nozzle_width+hose_od+6*nozzle_width+8.4, 4*nozzle_width])
                cube([dust_shoe_width-2*4*nozzle_width, 10+0.1, dust_show_opening_height]);
        }

        translate([-dust_shoe_width/2-0.1, 6*nozzle_width+hose_od+6*nozzle_width+8.4+10, -0.1])
            cube([dust_shoe_width+0.2, dust_shoe_depth, 4*nozzle_width+dust_show_opening_height+0.1]);

        translate([0, 6*nozzle_width+hose_od+6*nozzle_width+8.4+10, -0.1])
            cylinder(d=dust_shoe_width-2*4*nozzle_width, h=4*nozzle_width+0.2, $fn=64);

        translate([0, 6*nozzle_width+hose_od/2, 4*nozzle_width])
            cylinder(d=hose_id, h=dust_shoe_height-4*nozzle_width+0.1, $fn=64);

        translate([0, 6*nozzle_width+hose_od/2, dust_shoe_height-mounting_hole_depth-play])
            cylinder(d=hose_id+2*6*nozzle_width+play, h=mounting_hole_depth+play+0.1, $fn=64);

        translate([0, 6*nozzle_width+hose_od/2, dust_shoe_height-3-0.1])
            cylinder(d1=hose_id+2*6*nozzle_width+play-0.1, d2=hose_id+2*6*nozzle_width+play+3.1, h=3.2, $fn=64);

        translate([0, 6*nozzle_width+hose_od/2, dust_shoe_height-mounting_hole_depth*3/4])
        for(i=[-1, 1]) {
            translate([i*((hose_id+2*t)/2-t), 0, 0])
            linear_extrude(mounting_hole_depth*3/4+0.1)
                circle(d=3*t+play, $fn=32);

            rotate_extrude(angle=90, convexity=10, $fn=64)
            translate([i*((hose_id+2*t)/2-t), 0, 0])
                circle(d=3*t+play, $fn=32);

            translate([i*((hose_id+2*t)/2-t), 0, 0])
                sphere(d=3*t+play, $fn=32);

            translate([0, i*((hose_id+2*t)/2-t), 0])
                sphere(d=3*t+play, $fn=32);
        }

        for (a=[-45, 45])
        rotate([0, 0, a])
        translate([-50, -26, -0.1])
            cube([100, 20, dust_shoe_height+0.2]);
    }
}


rotate([90, 0 ,0])
    dust_shoe();
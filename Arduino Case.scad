// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains the parts for the Arduino case and the CNC shield.

include <Measurements.scad>


module arduino_case_bottom() {
    difference() {
        union() {
            difference() {
                cube([arduino_case_width, arduino_case_depth, arduino_case_height]);

                translate([arduino_case_wall_thickness, arduino_case_wall_thickness, arduino_case_wall_thickness])
                    cube([arduino_case_width-2*arduino_case_wall_thickness, arduino_case_depth-2*arduino_case_wall_thickness, arduino_case_height-arduino_case_wall_thickness+0.1]);
                
                translate([-0.1, arduino_case_wall_thickness+5, arduino_case_standoff_height+5])
                    cube([arduino_case_width+0.2, arduino_case_depth-2*(arduino_case_wall_thickness+5), arduino_case_height-arduino_case_wall_thickness+0.1]);
                
                // on/off switch
                translate([arduino_case_width/2-6.5, -0.1, arduino_case_wall_thickness+2])
                    cube([13, arduino_case_wall_thickness+0.2, 20.2]);

                // power plug
                translate([arduino_case_wall_thickness+2+7, arduino_case_depth-arduino_case_wall_thickness-0.1, arduino_case_wall_thickness+2+7])
                rotate([-90, 0, 0])
                    cylinder(d=8, h=arduino_case_wall_thickness+0.2, $fn=32);
                
                // usb plug
                translate([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width+arduino_uno_usb_plug_y_offset, arduino_case_depth-arduino_case_wall_thickness-0.1, arduino_case_wall_thickness+arduino_case_standoff_height+arduino_uno_pcb_height])
                    cube([13, arduino_case_wall_thickness+0.2, usb_type_a_plug_height]);
                
                // rear cable entry
                translate([arduino_case_width/2, arduino_case_depth+0.1, arduino_case_height-10]) {
                    rotate([90, 0, 0])
                        cylinder(d=10, h=arduino_case_wall_thickness+0.2, $fn=64);
                    
                    translate([-5, -arduino_case_wall_thickness-0.2, 0])
                        cube([10, arduino_case_wall_thickness+0.2, 10.1]);
                }
                
                for (i=[-0.1, arduino_case_width-arduino_case_wall_thickness-0.1])
                for (j=[10, arduino_case_depth-10])
                translate([i, j, arduino_case_wall_thickness+5/2])
                rotate([0, 90, 0])
                    cylinder(d=2, h=arduino_case_wall_thickness+0.2, $fn=16);
            }
            
            translate([0, arduino_case_depth+arduino_uno_usb_plug_x_offset-arduino_uno_mounting_holes[0][0]-arduino_case_wall_thickness/2, 0])
                cube([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width+arduino_uno_mounting_holes[0][1],
                      arduino_case_wall_thickness,
                      arduino_case_wall_thickness+arduino_case_standoff_height]);
            
            translate([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width+arduino_uno_mounting_holes[1][1]-arduino_case_wall_thickness/2, 0, 0])
                cube([arduino_case_wall_thickness,
                      arduino_case_depth+arduino_uno_usb_plug_x_offset-arduino_uno_mounting_holes[1][0],
                      arduino_case_wall_thickness+arduino_case_standoff_height]);

            translate([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width+arduino_uno_mounting_holes[2][1]-arduino_case_wall_thickness/2, 0, 0])
                cube([arduino_case_wall_thickness,
                      arduino_case_depth+arduino_uno_usb_plug_x_offset-arduino_uno_mounting_holes[2][0],
                      arduino_case_wall_thickness+arduino_case_standoff_height]);

            translate([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width+arduino_uno_mounting_holes[3][1], 
                       arduino_case_depth+arduino_uno_usb_plug_x_offset-arduino_uno_mounting_holes[3][0]-arduino_case_wall_thickness/2, 0])
                cube([arduino_case_wall_thickness+arduino_case_pcb_clearance+arduino_uno_pcb_width-arduino_uno_mounting_holes[3][1],
                      arduino_case_wall_thickness,
                      arduino_case_wall_thickness+arduino_case_standoff_height]);
            
            for (p = arduino_uno_mounting_holes) {
                translate([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width+p[1], arduino_case_depth+arduino_uno_usb_plug_x_offset-p[0], 0])
                    cylinder(d=2+1.4*arduino_case_wall_thickness, h=arduino_case_wall_thickness+arduino_case_standoff_height, $fn=32);
            }
        }
        
        for (p = arduino_uno_mounting_holes) {
            translate([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width+p[1], arduino_case_depth+arduino_uno_usb_plug_x_offset-p[0], 0.4])
                cylinder(d=2, h=arduino_case_wall_thickness+arduino_case_standoff_height+0.2, $fn=16);
        }
    }
    
    *translate([arduino_case_width-arduino_case_wall_thickness-arduino_case_pcb_clearance-arduino_uno_pcb_width, arduino_case_depth+arduino_uno_usb_plug_x_offset, arduino_case_wall_thickness+arduino_case_standoff_height])
    rotate([0, 0, -90])
    color("darkblue", alpha=0.2)
        arduino_uno();
}

module arduino_case_top() {
    union() {
        difference() {
            translate([0, 0, arduino_case_wall_thickness+5+play/2])
                cube([arduino_case_width, arduino_case_depth, arduino_case_height-5-play/2]);
            
            translate([arduino_case_wall_thickness+play/2, -0.1, 0])
                cube([arduino_case_width-2*arduino_case_wall_thickness-play, arduino_case_depth+0.2, arduino_case_height]);
            
            translate([-0.1, -0.1, 0])
                cube([arduino_case_width+0.2, arduino_case_wall_thickness+5+play/2+0.1, arduino_case_height]);

            translate([-0.1, arduino_case_depth-arduino_case_wall_thickness-5-play/2, 0])
                cube([arduino_case_width+0.2, arduino_case_wall_thickness+5+play/2+0.1, arduino_case_height]);
            
            translate([arduino_case_width/2, 2*arduino_case_wall_thickness+12, arduino_case_height-0.1])
                cylinder(d=16, h=arduino_case_wall_thickness+0.2, $fn=64);

            for (i=[-9:1:9])
            for (j=[-0.1, arduino_case_width-0.8-15])
            translate([j, arduino_case_depth/2-0.8+i*(1.7*arduino_case_wall_thickness), arduino_case_wall_thickness+10])
                cube([arduino_case_wall_thickness+15.1, 1.6, arduino_case_height-10+0.1]);
        }
        
        for (i=[arduino_case_wall_thickness+play/2, arduino_case_depth-2*arduino_case_wall_thickness-play/2])
        translate([arduino_case_wall_thickness+play/2, i, arduino_case_height-5])
            cube([arduino_case_width-2*arduino_case_wall_thickness-play, arduino_case_wall_thickness, 5]);

        difference() {
            union() {
                for (i=[arduino_case_wall_thickness+play/2, arduino_case_width-2*arduino_case_wall_thickness-play/2])
                for (j=[arduino_case_wall_thickness+play/2, arduino_case_depth-2*arduino_case_wall_thickness-5-play/2])
                translate([i, j, arduino_case_wall_thickness+play/2])
                    cube([arduino_case_wall_thickness, 5+arduino_case_wall_thickness, arduino_case_height-arduino_case_wall_thickness-play/2]);

                for (i=[arduino_case_wall_thickness+play/2, arduino_case_width-2*arduino_case_wall_thickness-play/2])
                for (j=[arduino_case_wall_thickness+play/2, arduino_case_depth-2*arduino_case_wall_thickness-8-play/2])
                translate([i, j, arduino_case_wall_thickness+play/2])
                    cube([arduino_case_wall_thickness, 8+arduino_case_wall_thickness, 2*arduino_case_wall_thickness]);

                for (i=[arduino_case_wall_thickness+play/2, arduino_case_width-2*arduino_case_wall_thickness-play/2])
                translate([i, arduino_case_wall_thickness+play/2, arduino_case_wall_thickness+play/2+3])
                    cube([arduino_case_wall_thickness, arduino_case_depth-2*arduino_case_wall_thickness-play,2+arduino_case_wall_thickness]);
            }
            
            for (i=[-0.1, arduino_case_width-2*arduino_case_wall_thickness-0.2])
            for (j=[10, arduino_case_depth-10])
            translate([i, j, arduino_case_wall_thickness+5/2])
            rotate([0, 90, 0])
                cylinder(d=2, h=2*arduino_case_wall_thickness+0.3, $fn=16);
        }
        
        translate([arduino_case_wall_thickness+play/2, arduino_case_wall_thickness+play/2, 2*arduino_case_wall_thickness+play/2+5])
        rotate([-90, -90, 0])
            wedge(arduino_case_wall_thickness, arduino_case_wall_thickness, arduino_case_depth-2*arduino_case_wall_thickness-play);

        translate([arduino_case_width-arduino_case_wall_thickness-play/2, arduino_case_wall_thickness+play/2, 2*arduino_case_wall_thickness+play/2+5])
        rotate([-90, 180, 0])
            wedge(arduino_case_wall_thickness, arduino_case_wall_thickness, arduino_case_depth-2*arduino_case_wall_thickness-play);
    }
}


arduino_case_bottom();

translate([-5, 0, arduino_case_height+arduino_case_wall_thickness])
rotate([0, 180, 0])
    arduino_case_top();
// CNC Engraver
// https://github.com/mprochnow/CNC-Engraver
// Original author: Martin J. Prochnow <email@martin-prochnow.de>
// License: CC BY-SA 4.0 (Attribution-ShareAlike 4.0 International, http://creativecommons.org/licenses/by-sa/4.0/)

// This file contains the template for drilling the needed holes into the
// aluminium extrusions.

difference() {
    union() {
        translate([0, -20])
            cube([60, 40, 5]);
        
        for (i=[-1, 1])
        translate([0, -4.9/2+i*10, 5])
            cube([60, 4.9, 2]);
    }
    for (i=[10, 30, 50])
    for (j=[-1, 1])
    translate([i, j*10, -0.1])
        cylinder(d=4.7, h=5+2+0.2, $fn=32);
}
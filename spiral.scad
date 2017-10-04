/*
Dimensions: overall diameter is 4.5 inches.
Label will be 1.6" wide. Hole in center is 1/8".
*/

$fn = 60;
height = 1;
SCALE = (4.5 / 12) * 25.4;
outermost = SCALE * 12;
hole = SCALE * (1/3);
label = SCALE * 4.3;
inner_gap = SCALE * 3/4;
outer_gap = SCALE * 1/16;

module spiral(inner, outer)
{
    width = 1;
    delta = 2 * width;
    loops = (outer - inner) / delta;
    linear_extrude(height=1) polygon(points=concat(
        [for(t = [0:3:360*loops+1])
            [(inner-width+delta*t/360)*cos(t),
             (inner-width+delta*t/360)*sin(t)]],
        [for(t = [360*loops:-3:-1])
            [(inner+t*delta/360)*cos(t),
             (inner+delta*t/360)*sin(t)]]
    ));
}

difference() {
    cylinder(h=height, d=outermost);
    union() {
        translate([0, 0, -1])
            cylinder(d=hole, h=height + 2);
        translate([0, 0, height - 0.5])
            spiral(label/2 + inner_gap,
                outermost/2 - outer_gap);
    }
}

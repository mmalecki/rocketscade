include <catchnhole/catchnhole.scad>;

module circle_sleeve (inner_d, thickness) {
  difference () {
    circle(r = inner_d / 2 + thickness);
    circle(r = inner_d / 2);
  }
}

module cylinder_sleeve (height, inner_d, thickness) {
  linear_extrude(height) {
    circle_sleeve(inner_d, thickness);
  }
}

module radial_cluster (count) {
  angle = 360 / count;
  for (i = [1 : count]) {
    rotate([0, 0, i * angle]) {
      children();
    }
  }
}

module hole_through_radial_cluster (hole_offset, hole_count, screw_dia, length) {
  radial_cluster(hole_count) {
    translate([hole_offset, 0, 0])
      rotate([0, 270, 0])
        bolt(str("M", screw_dia), length = length);
  }
}


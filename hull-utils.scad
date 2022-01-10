include <utils.scad>;

module cylinder_sleeve_with_coupler_holes (height, inner_d, thickness, hole_offset, hole_count, screw_dia, screw_length) {
  difference () {
    cylinder_sleeve(height, inner_d, thickness);

    rotate([0, 0, 45]) {
      translate([0, 0, hole_offset + screw_dia / 2])
        hole_through_radial_cluster(inner_d / 2 + thickness, 3, screw_dia, screw_length);

      translate([0, 0, height - hole_offset - screw_dia / 2])
        hole_through_radial_cluster(inner_d / 2 + thickness, 3, screw_dia, screw_length);
    }
  }
}

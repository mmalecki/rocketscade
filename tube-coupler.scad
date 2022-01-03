include <utils.scad>

module tube_coupler(d1, d2, h1, h2, h_stopper, screw_dia, screw_offset, screw_mount_width, screw_mount_depth, sleeve_thickness, screw_count = 3) {
  // Coupler sleeves:
  cylinder_sleeve(h1, d1, sleeve_thickness);

  translate([0, 0, h1]) {
    difference () {
      cylinder(
        h = h_stopper,
        r1 = d1 / 2 + sleeve_thickness,
        r2 = d2 / 2 + sleeve_thickness
      );

      cylinder(
        h = h_stopper,
        d1 = d1,
        d2 = d2
      );
    }

    translate([0, 0, h_stopper]) cylinder_sleeve(h2, d2, sleeve_thickness);
  }
}

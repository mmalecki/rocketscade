include <utils.scad>;
include <mounts.scad>;
include <tube-coupler.scad>
include <nutsnbolts/cyl_head_bolt.scad>;

module nose_cone_mount_positive(d1, d2, h1, h2, h_stopper, screw_dia, nutcatch_offset, screw_offset, screw_mount_width, screw_mount_depth, sleeve_thickness, screw_count = 3) {

  // Nose cone mount sleeves:
  cylinder_sleeve(h1, d1, sleeve_thickness);
  translate([0, 0, h1 + h_stopper]) cylinder_sleeve(h2, d2, sleeve_thickness);

  // The middle stopper:
  translate([0, 0, h1]) {
    cylinder(
      h = h_stopper,
      d1 = d1 + 4 * sleeve_thickness,
      d2 = d2 + 4 * sleeve_thickness
    );
  }

  // The nose-side screws:
  translate([0, 0, h1 + h2 + h_stopper]) {
    mirror([0, 0, 1]) 
      tube_coupler_screw_mount_cluster(
        screw_mount_depth,
        screw_mount_width,
        h2 + h_stopper / 2,
        d2 / 2,
        screw_dia,
        screw_offset,
        nutcatch_offset,
        screw_count
      );
  }
}

module nose_cone_mount(d1, d2, h1, h2, h_stopper, screw_dia, nutcatch_offset, screw_offset, screw_mount_width, screw_mount_depth, sleeve_thickness, mount_length, mount_height, mount_slope0, mount_slope1, mount_thickness, screw_count = 3) {

  difference () {
    nose_cone_mount_positive(d1, d2, h1, h2, h_stopper, screw_dia, nutcatch_offset, screw_offset, screw_mount_width, screw_mount_depth, sleeve_thickness, screw_count);

    translate([0, 0, h1 + h2 + h_stopper - screw_offset - screw_dia / 2]) {
      mirror([0, 0, 1]) {
        hole_through_radial_cluster(d1 / 2 + sleeve_thickness, screw_count, screw_dia, screw_mount_depth + sleeve_thickness);
      }
    }
  }

  translate([-mount_length / 2, mount_height / 2, h2]) {
    mirror([0, 1, 1])
      internal_mount(mount_length, mount_height, mount_slope0, mount_slope1, mount_thickness);
  }
}

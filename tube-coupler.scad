include <utils.scad>;

module tube_coupler_screw_mount_cluster(depth, width, height, mount_offset, screw_dia, screw_offset, nutcatch_offset, screw_count) {
  radial_cluster(screw_count) {
    translate([mount_offset - screw_mount_depth, -screw_mount_width / 2, 0])
      tube_coupler_screw_mount(
        depth,
        width,
        height,
        screw_dia,
        screw_offset,
        nutcatch_offset
      );
  }
}

module tube_coupler_screw_mount(depth, width, height, screw_dia, screw_offset, nutcatch_offset) {
  difference () {
    cube([depth, width, height]);
    translate([depth - nutcatch_offset, width / 2, screw_offset + screw_dia / 2]) {
      rotate([0, 90, 0]) nutcatch_sidecut(str("M", screw_dia));
    }
  }
}

module tube_coupler_positive(d1, d2, h1, h2, h_stopper, screw_dia, nutcatch_offset, screw_offset, screw_mount_width, screw_mount_depth, sleeve_thickness, screw_count = 3) {

  // Coupler sleeves:
  cylinder_sleeve(h1, d1, sleeve_thickness);
  translate([0, 0, h1 + h_stopper]) cylinder_sleeve(h2, d2, sleeve_thickness);

  // The middle stopper:
  translate([0, 0, h1]) {
    difference () {
      cylinder(
        h = h_stopper,
        d1 = d1 + 4 * sleeve_thickness,
        d2 = d2 + 4 * sleeve_thickness
      );

      cylinder(
        h = h_stopper,
        d1 = d1,
        d2 = d2
      );
    }
  }

  // The screw mounts:
  tube_coupler_screw_mount_cluster(
    screw_mount_depth,
    screw_mount_width,
    h1 + h_stopper / 2,
    d1 / 2,
    screw_dia,
    screw_offset,
    nutcatch_offset,
    screw_count
  );

  // We're mirroring the coupler screw mount cluster, so we're drawing down:
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

module tube_coupler(d1, d2, h1, h2, h_stopper, screw_dia, nutcatch_offset, screw_offset, screw_mount_width, screw_mount_depth, sleeve_thickness, screw_count = 3) {

  difference () {
    tube_coupler_positive(d1, d2, h1, h2, h_stopper, screw_dia, nutcatch_offset, screw_offset, screw_mount_width, screw_mount_depth, sleeve_thickness, screw_count);

    translate([0, 0, screw_offset + screw_dia / 2])
      hole_through_radial_cluster(d1 / 2 + sleeve_thickness, screw_count, screw_dia, screw_mount_depth + sleeve_thickness);

    translate([0, 0, h1 + h2 + h_stopper - screw_offset - screw_dia / 2]) {
      mirror([0, 0, 1]) 
        hole_through_radial_cluster(d2 / 2 + sleeve_thickness, screw_count, screw_dia, screw_mount_depth + sleeve_thickness);
    }
  }
}

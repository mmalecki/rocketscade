module cylinder_sleeve (height, inner_d, thickness) {
  linear_extrude(height) {
    difference () {
      circle(d = inner_d + thickness);
      circle(d = inner_d);
    }
  }
}

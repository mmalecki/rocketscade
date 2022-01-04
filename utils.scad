module circle_sleeve (inner_d, thickness) {
  difference () {
    circle(d = inner_d + 2 * thickness);
    circle(d = inner_d);
  }
}

module cylinder_sleeve (height, inner_d, thickness) {
  linear_extrude(height) {
    circle_sleeve(inner_d, thickness);
  }
}

module radial_cluster (count) {
  angle = 360 / count;
  for (i = [1 : angle]) {
    rotate([0, 0, i * angle]) {
      render() children();
    }
  }
}

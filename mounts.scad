module internal_mount_2d (length, height, slope0, slope1, thickness) {
  polygon(
    points = [
      [0, 0], 
      [slope0, height],
      [length + slope0, height], 
      [length + slope0 + slope1, 0],

      [thickness, 0],
      [slope0 + thickness, height - thickness],
      [length + slope0 - thickness, height - thickness],
      [length + slope0 + slope1 - thickness,  0]

    ],
    paths = [[0, 1, 2, 3], [4, 5, 6, 7]]
  );
}

module internal_mount (length, height, slope0, slope1, thickness) {
  linear_extrude(height, $fn = 1, convexity = 1) internal_mount_2d(length, height, slope0, slope1, thickness);
}

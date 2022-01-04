module fin (root_chord, height, sweep_length, tip_chord, fillet_r) {
  hull () {
    // Start at the bottom of the root chord.
    sphere(r = fillet_r);
    // Then, to the top of the root chord.
    translate([0, 0, root_chord]) sphere(r = fillet_r);

    translate([height, 0, -(sweep_length - root_chord)]) sphere(r = fillet_r);

    translate([height, 0, -(sweep_length - root_chord) - tip_chord]) sphere(r = fillet_r);
  }
}

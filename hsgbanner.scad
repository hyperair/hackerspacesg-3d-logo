text_thickness = 5;
base_thickness = 3;
text_hole_depth = 1;
base_thickness_in_hole = base_thickness - text_hole_depth;
border_thickness = text_thickness;
border_width = 2;

keyring_hole_radius = 3;

module hsgbanner_bg() {
    import("hsgbanner.dxf", layer="background");
}

module hsgbanner_bg_border() {
    difference() {
        hsgbanner_bg();
        offset(delta=-border_width, join_type="round")
        hsgbanner_bg();
    }
}

module hsgbanner_base() {
    difference() {
        // Actual base
        color("red") {
            linear_extrude(height=base_thickness)
            hsgbanner_bg();

            linear_extrude(height=border_thickness)
            hsgbanner_bg_border();
        }

        // Hole for text to fit in, minkowski'd for some printing tolerance
        render() {
            minkowski() {
                hsgbanner_place_fg()
                hsgbanner_extruded_fg();

                sphere(r=0.05, center=true, $fn=3);
            }
        }

        if (keyring_hole_radius > 0) {
            translate([6.5, 6.5, -0.1])
            cylinder(r=keyring_hole_radius, h=base_thickness + 0.2, $fn=20);
        }
    }
}

module hsgbanner_fg() {
    import("hsgbanner.dxf", layer="text");
    import("hsgbanner.dxf", layer="stars");
}

module hsgbanner_extruded_fg() {
    color("white")
    linear_extrude(height=text_thickness - base_thickness_in_hole)
    hsgbanner_fg();
}

module hsgbanner_place_fg() {
    translate([0, 0, base_thickness_in_hole])
    children();
}

hsgbanner_base();

hsgbanner_place_fg()
hsgbanner_extruded_fg();

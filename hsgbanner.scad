text_thickness = 2;
base_thickness = 1;
text_hole_depth = min(0.5 * base_thickness, 2);
base_thickness_in_hole = base_thickness - text_hole_depth;
border_thickness = text_thickness;
border_width = 2;

// original dimensions. FIXME: Use dxf_dim to get these out
orig_length = 195.324;
orig_breadth = 35.712;
orig_hole_position = [4.5, 4.5];
orig_hole_radius = 3;

target_length = 100;

scale_factor = target_length / orig_length;
hole_position = orig_hole_position * scale_factor + [border_width, border_width];
hole_radius = orig_hole_radius * scale_factor;

module hsgbanner_scale() {
    scale([scale_factor, scale_factor, scale_factor]) children();
}

module hsgbanner_bg() {
    hsgbanner_scale()
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

        if (hole_radius > 0) {
            translate([hole_position[0], hole_position[1], -0.1])
            cylinder(r=hole_radius, h=base_thickness + 0.2, $fn=20);
        }
    }
}

module hsgbanner_fg() {
    hsgbanner_scale() {
        import("hsgbanner.dxf", layer="text");
        import("hsgbanner.dxf", layer="stars");
    }
}

module hsgbanner_extruded_fg() {
    color("white")
    linear_extrude(height=text_thickness - base_thickness_in_hole)
    hsgbanner_fg();
}

module hsgbanner_fg_holes() {
    // Hole for text to fit in, minkowski'd for some printing tolerance
    render() {
        minkowski() {
            hsgbanner_place_fg()
            hsgbanner_extruded_fg();

            sphere(r=0.05, center=true, $fn=3);
        }
    }
}

module hsgbanner_place_fg() {
    translate([0, 0, base_thickness_in_hole])
    children();
}

hsgbanner_base();

hsgbanner_place_fg()
hsgbanner_extruded_fg();

// ruler showing original size
*cube([orig_length, orig_breadth, max(text_thickness, border_thickness)]);

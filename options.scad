text_thickness = 2;
base_thickness = 1;
text_hole_depth = 0; // min(0.5 * base_thickness, 2);
base_thickness_in_hole = base_thickness - text_hole_depth;
border_thickness = text_thickness;
border_width = 1;

// original dimensions. FIXME: Use dxf_dim to get these out
orig_length = 195.324;
orig_breadth = 35.712;
orig_hole_position = [4.5, 4.5];
orig_hole_radius = 3;

target_length = 100;

scale_factor = target_length / orig_length;
hole_position = orig_hole_position * scale_factor + [border_width, border_width];
hole_radius = orig_hole_radius * scale_factor;

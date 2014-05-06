text_thickness = 5;
base_thickness = 3;
border_thickness = text_thickness;
border_width = 2;

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

module hsgbanner_fg() {
    import("hsgbanner.dxf", layer="text");
    import("hsgbanner.dxf", layer="stars");
}

color("red") {
    linear_extrude(height=base_thickness)
    hsgbanner_bg();

    linear_extrude(height=border_thickness)
    hsgbanner_bg_border();
}

color("white")
linear_extrude(height=text_thickness)
hsgbanner_fg();

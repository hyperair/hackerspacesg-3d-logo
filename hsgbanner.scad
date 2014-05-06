linear_extrude(height=5)
difference() {
    import("hsgbanner.dxf", layer="background");
    import("hsgbanner.dxf", layer="text");
    import("hsgbanner.dxf", layer="stars");
}

// Special control variable for the number of facets used to generate an arc
$fn = 100;

// Radius of the corner in mm
radius = 10;

// Thickness of the sander guide
frameThickness = 4;
frameRoundover = 1;
// Length of the sander guide
frameExtension = 25;

// Length of the slot for the sanding paper in mm
slotLength = 98;

// Thickness of the slot for the sanding paper in mm
sandpaperThickness = 0.75;
slotThickness = sandpaperThickness + 0.25;

// Amount of frame on each side of the slot in mm
slotPadding = 10;

// Size of the solid block to cut out the cylinder in mm
size = radius+frameThickness;
// Total width in mm
guideWidth = size + frameExtension;
// Total length of the sanding block in mm
length = slotLength + (slotPadding*2);

// When doing differences, need to remove zero-thickness polygons
buffer = 1;

difference() {
    union() {
        minkowski() {
            cube([size, size, length]);
            sphere(frameRoundover, center=true);
        }

        minkowski() {
            cube([guideWidth, frameThickness, length]);
            sphere(frameRoundover, center=true);
        }
        
        minkowski() {
        cube([frameThickness, guideWidth, length]);
            sphere(frameRoundover, center=true);
        }
    }

    // Cylinder
    translate([size-sandpaperThickness, size-sandpaperThickness, -buffer])
    cylinder(length+(buffer*2), radius, radius+0);

    // Slot 1
    translate([-slotThickness, size-slotThickness, slotPadding])
    cube([size, slotThickness, slotLength]);

    // Slot 2
    translate([size-slotThickness, -slotThickness, slotPadding])
    cube([slotThickness, size, slotLength]);
}

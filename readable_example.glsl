// Created by Casper Norén - CasperNoren @ GitHub
#define PI     3.14159

// Shapes
// Basic: https://iquilezles.org/articles/distfunctions2d/
// Cut-up: https://iquilezles.org/articles/distgradfunctions2d/
// Gradient: https://iquilezles.org/articles/distgradfunctions2d/

vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    // Test values: http://dev.thi.ng/gradients/
    // Each value = vec3(red, green, blue)
    
    // a: y-Offset
    // b: Amp
    // c: Frequency
    // d: x-Offset (phase)
    
    // Oscilates c times with phase of d
    // Scaled and biased by a and b for ccontrast and brightness
    // If palette needs to cycle over 0..1 exactly make c = [int] * 0.5
    // For continuity make c = [int]
    return a + b*cos( 2.0*PI *(c*t+d) );
}

vec3 usePalette(float t) {
    // Test values: http://dev.thi.ng/gradients/
    vec3 a = vec3(0.5, 0.5, 2.0);
    vec3 b = vec3(0.5, 0.2, 0.5);
    vec3 c = vec3(2.0, 3.0, 1.0);
    vec3 d = vec3(1.358, 0.5, 0.5);
    
    return palette(t, a, b, c, d);
}

float halfScreenValuePicker(float x, float leftVal, float rightVal) {
    if (x < iResolution.x / 2.0) {
        return leftVal;
    }
    return rightVal;
}

// Range canvas from -0.5 to 0.5
vec2 centeredNormCanvas(vec2 fragCoord) {
    return (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
}

vec2 addSpatialRepetion(vec2 uv, float scale) {
    return fract(uv * scale) - 0.5;
}

// pointOriginal: value of point when initilized
float pointDistanceCurved(vec2 point, vec2 pointOriginal) {
    return length(point) * exp(-length(pointOriginal));
}

float sinRings(float d, float t, float speed, float width) {
    return sin(d*speed + t)/width;
}

float glow(float d, float intensity, float contrast) {
    return pow(intensity / d, contrast);
}

vec3 scaleColorWithDistance(vec3 col, float d) {
    return col * d;
}

vec3 invert(vec3 v) {
    return vec3(1.0) - v;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Range canvas from -0.5 to 0.5
    //vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    vec2 uv = centeredNormCanvas(fragCoord);
    // Original uv
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    // Iterate to create layers
    // Increase limit to add more layers
    for (float i = 0.0; i < 3.0; i++) {
        // Add spatial repetion
        // Non-int scalar for patterns
        // -0.5 lines fract up with middle
        uv = addSpatialRepetion(uv, 1.8);
    
        // Distance from center with slight curve added
        float d = pointDistanceCurved(uv, uv0);
        
        // Rings changes with each iteration
        vec3 col = usePalette(length(uv0) + i*1.5 + iTime*0.4);
        
        // Repeating rings in different phases with scalable with
        d = sinRings(d, iTime, 8., 8.);
        
        // Inside also gives positive 
        d = abs(d);
        
        // Glow intensity, second: contrast
        d = glow(d, 0.013, 2.);
        
        // Glow changes with distance
        finalColor += scaleColorWithDistance(col, d);
    }
    finalColor = invert(finalColor);

    // Output to screen
    fragColor = vec4(finalColor,1.0);
}

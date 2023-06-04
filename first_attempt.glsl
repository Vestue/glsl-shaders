void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    
    float d = length(uv);
    d = sin(d * 8. + iTime)/8.;
    d = abs(d);
    
    d = 0.02 / d;    
    
    vec3 colorLayer = vec3(0.0, 1.0, 1.0);
    colorLayer *= d;

    fragColor = vec4(colorLayer, 1.0);
}

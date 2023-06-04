vec3 palette( float t ) 
{
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(0.8, 0.8, 0.5);
    vec3 d = vec3(0.0, 0.2, 0.5);
    
    return a + b * cos(6.28318 * (c * t + d));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    
    float d = length(uv);
    vec3 colors = palette(d + iTime);
    d = sin(d * 8. + iTime)/8.;
    d = abs(d);
    
    d = 0.02 / d;    
    
    
    colors *= d;

    fragColor = vec4(colors, 1.0);
}

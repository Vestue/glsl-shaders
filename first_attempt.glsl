vec3 palette( float t ) 
{
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(-0.562, -0.342, 0.158);
    vec3 c = vec3(1.118, 1.0, 2.648);
    vec3 d = vec3(-1.052, 0.333, 0.667);
    
    return a + b * cos(6.28318 * (c * t + d));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    
    float d = length(uv);
    d = sin(d * 8. + iTime)/8.;
    d = abs(d);
    
    d = 0.02 / d;    
    
    vec3 colors = palette(d + iTime);
    colors *= d;

    fragColor = vec4(colors, 1.0);
}

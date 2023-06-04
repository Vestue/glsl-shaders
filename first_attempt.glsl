void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    
    float centerDistance = length(uv);

    fragColor = vec4(centerDistance, centerDistance, centerDistance, 1.0);
}

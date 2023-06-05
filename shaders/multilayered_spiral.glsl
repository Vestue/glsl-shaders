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
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    float centerDistance = 0.5;
    
    for (int i = 0; i < 2; i++)
    {
        vec2 uv1 = fract(uv * 2.0) - centerDistance;
        float d = length(uv1) * exp(-length(uv0));
        
        d = sin(d * 4. + iTime)/8.;
        d = abs(d);
        d = pow(0.02 / d, 2.0);
        
        vec2 uv2 = fract(uv * 2.0) - centerDistance;
        float secondLayer = length(uv2) * exp(-length(uv0));
        secondLayer = sin(secondLayer * 28. + iTime) / 20.;
        secondLayer = abs(secondLayer);
        secondLayer = pow(0.01 / secondLayer, 2.0);

        vec3 colors = palette(length(uv0) + iTime*.4);
        finalColor += colors * d;
        finalColor += colors * secondLayer;
    }
    

    fragColor = vec4(finalColor, 1.0);
}

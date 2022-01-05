#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/coord-ops.glsl"
#include "../libs/local/colors.glsl"
#include "../libs/local/math.glsl"
#include "../libs/local/boolean-ops.glsl"

float noise( vec2 p )
{
	return sin(p.x)*sin(p.y);
}

float fbm( vec2 p ){
    float f = 0.0;
    mat2 m = mat2(0.80,  0.60, -0.60,  0.80);
    
    f += 0.5 * noise(p);

    p = m * p * 2.02;
    f += 0.25 * noise(p);

    p = m * p * 2.02;
    f += 0.125 * noise(p); 
    
    p = m * p * 2.02; // 100.
    f += 0.0625 * noise(p);
    
    return f;
}

float pattern( vec2 coord )
{
    return fbm(
        coord 
        + adjustedSin(u_time, 0.5, 4.0, 20.)
        * fbm(coord + 4.0 
            * fbm(coord + 4.0 
               * fbm(coord)
            )
        )
    );
}

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution.xy);

    gl_FragColor = mix(BLACK, WHITE, pattern(coord));
}
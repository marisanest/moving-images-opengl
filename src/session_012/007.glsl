// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

#include "../libs/local/random.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/2dshapes.glsl"

uniform vec2 u_resolution;
uniform float u_time;

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    coord = fixCoordRatio(coord, u_resolution);
    
    coord *= 3.;

    float df = 0.0;

    // Add a random position
    float a = 0.0;
    
    // vel (velocity?) is getting higher and higher
    vec2 vel = vec2(u_time * .1);
    
    df = snoise(coord + vel) * .25 + .25;

    // Add a random position
    a = snoise(coord * vec2(cos(u_time * 0.15), sin(u_time * 0.1)) * 0.1) * PI;
    
    // vel (velocity?) is always between -1 and 1 for both x and y but randomly
    vel = vec2(cos(a), sin(a));
    
    df += snoise(coord + vel) * .25 + .25;

    float color = smoothstep(.7, .75, fract(df));
    color = 1. - color;

    gl_FragColor = vec4(vec3(color), 1.0);
}
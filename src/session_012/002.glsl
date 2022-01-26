#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

#include "../libs/local/random.glsl"
#include "../libs/local/coord-ops.glsl"

void main(){
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    // coord = fixCoordRatio(coord, u_resolution);

    coord *= 4.0; 
    float color = vnoise(coord);

    gl_FragColor = vec4(vec3(color), 1.0);
}
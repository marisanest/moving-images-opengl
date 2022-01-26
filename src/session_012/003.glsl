#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/random.glsl"
#include "../libs/local/coord-ops.glsl"

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    coord = fixCoordRatio(coord, u_resolution);

    coord *= 10.0;

    float color = gnoise(coord);
    color *= .5; 
    color += .5;
    
    gl_FragColor = vec4(vec3(color), 1.0);
}
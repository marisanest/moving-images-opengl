// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

// My own port of this processing code by @beesandbombs
// https://dribbble.com/shots/1696376-Circle-wave
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/random.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/2dshapes.glsl"

float shape(vec2 coord, float radius) {
	coord = vec2(0.5) - coord;
    
    float r = length(coord) * 2.0;
    float a = atan(coord.y, coord.x);
    float m = abs(mod(a + u_time * 2., 3.14 * 2.) - 3.14) / 3.6;
    float f = radius;
    
    m += gnoise(coord + u_time * 0.1) * .5;
    f += sin(a * 50.) * gnoise(coord + u_time * .2) * .1;
    f += (sin(a * 20.) * .1 * pow(m, 2.));
    
    return 1. - smoothstep(f, f + 0.007, r);
}

float shapeBorder(vec2 st, float radius, float width) {
    return shape(st, radius) - shape(st, radius - width);
}

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    //coord = fixCoordRatio(coord, u_resolution);
	
    float color = shapeBorder(coord, 0.8, 0.02);
    color = 1. - color;

	gl_FragColor = vec4(vec3(color), 1.0);
}

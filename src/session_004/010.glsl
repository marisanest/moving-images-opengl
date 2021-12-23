#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/smiley.glsl"
#include "../libs/local/circle-line.glsl"
#include "../libs/local/colors.glsl"

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution);
    vec4 currentColor = WHITE;

    currentColor = smiley(coord, BLACK, currentColor * 5., mod(u_time, 10.) > 5.);

    gl_FragColor=currentColor;
}
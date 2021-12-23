#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/colors.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/smiley.glsl"
#include "../libs/local/circle-line.glsl"

void main() {
    vec2 st = setupCoord(gl_FragCoord.xy, u_resolution);
    vec4 currentColor = WHITE;

    currentColor = circleLine(st, BLACK, LILA, currentColor, 0.0, 1.0);
    currentColor = circleLine(st, LILA, BLACK, currentColor, 0.0, .0);

    currentColor = smiley(st, BLACK, currentColor, false);

    gl_FragColor=currentColor;
}
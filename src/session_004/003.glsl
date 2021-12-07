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
    vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 currentColor = BLACK;
    
    currentColor = circleLine(scaleCoord(st, vec2(0.2)), BLACK, WHITE, currentColor, 0.5, 0.);
    currentColor = circleLine(rotateCoord(scaleCoord(st, vec2(0.2)), 0.25 * M_PI), WHITE, BLACK, currentColor, 0.5, 0.0);
    currentColor = circleLine(rotateCoord(st, 0.25 * M_PI), WHITE, WHITE, currentColor, -1., 0.5);
    currentColor = circleLine(st, LILA, ORANGE, currentColor, 0.0, 0.5);
    currentColor = circleLine(st, ORANGE, LILA, currentColor, 0.5, 0.);
    currentColor = circleLine(scaleCoord(st, vec2(0.2)), BLACK, WHITE, currentColor, 0.5, 0.);
    
    //currentColor = smiley(st, BLACK, currentColor, mod(u_time, 10.) < 5.);
    
    gl_FragColor=currentColor;
}
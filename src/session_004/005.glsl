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
    vec4 currentColor = BLACK;

    vec2 lineSt = st;
    //lineSt *= 0.5;

    currentColor = circleLine(rotateCoord(lineSt, .75 * PI), WHITE, RED, currentColor, 0.0, .0);
    currentColor = circleLine(lineSt, WHITE, LILAC, currentColor, 0.0, 0.0);
    currentColor = circleLine(lineSt, WHITE, LILAC, currentColor, 1.0, .0);
    
    bool window = mod(u_time, 10.) < 5.;
    //window = false;
    currentColor = smiley(st, WHITE, currentColor, window);

    gl_FragColor=currentColor;
}
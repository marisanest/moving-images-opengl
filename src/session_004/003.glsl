#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/circle-line.glsl"

void main() {
    vec2 st = setupCoord(gl_FragCoord.xy, u_resolution);
    vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 currentColor = black;
    
    currentColor = circleLine(st, currentColor, 0.0, 0.5);
    currentColor = circleLine(st, currentColor, 0.5, 0.);
    
    gl_FragColor=currentColor;
}
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"

void main() {
    vec2 st = setupCoord(gl_FragCoord.xy, u_resolution);

    vec4 colorA = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 colorB = vec4(0.0, 1.0, 0.0, 1.0);
    vec4 colorC = vec4(0.0, 0.0, 1.0, 1.0);

    vec2 circleSt = st;
    vec2 boxSt = st;
    
    boxSt = rotateCoord(boxSt, u_time * 2.);
    
    float boxA = box(boxSt, vec2(0.25, 0.25));
    boxA = fill(boxA, 0.0);
    vec4 colorBox = mix(colorC, colorA, boxA);

    circleSt = translateCoord(circleSt, vec2(-sin(u_time), 0.0));
    circleSt = scaleCoord(circleSt, vec2(sin(u_time)));
    
    float circleA = circle(circleSt, 0.2);
    circleA = fill(circleA, 0.);
    vec4 colorCircle = mix(colorB, colorBox, circleA);

    gl_FragColor=colorCircle;
}
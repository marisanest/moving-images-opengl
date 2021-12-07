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

    vec4 colorA = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 colorB = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 resultColor;
    
    vec2 circleASt = st;
    vec2 circleBSt = st;

    circleASt = scaleCoord(circleASt, vec2(1., sin(u_time * 0.5) * sin(u_time)));
    circleASt = translateCoord(circleASt, vec2(0.2, 0.2));

    float circleA = circle(circleASt, 0.2);
    float circleStrokes = stroke(circleA, .002, 0.05, 0.05);
    resultColor = mix(colorA, colorB, circleStrokes);

    float circleB = circle(circleBSt, 0.2);
    circleStrokes = stroke(circleB, .002, 0.05, 0.05);
    resultColor = mix(colorB, resultColor, circleStrokes);

    gl_FragColor=resultColor;
}
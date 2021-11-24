#ifdef GL_ES
precision mediump float;
#endif

#define MAX_RADIUS 0.04
#define BOX_RADIUS 0.11

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/loops.glsl"
#include "../libs/local/style.glsl"

void main() {
    vec2 ratio = vec2(u_resolution.x / u_resolution.y, u_resolution.y / u_resolution.x);

    // why do we need to substract here?
    vec2 coord = gl_FragCoord.xy / u_resolution.xy;
    coord.x -= (ratio.y * BOX_RADIUS);
    coord.x *= ratio.x;
    coord.y -= BOX_RADIUS;

    vec2 nCircles = vec2(floor(ratio.x / (BOX_RADIUS * 2.)), floor(1.0 / (BOX_RADIUS * 2.)));
    vec2 margin = vec2((ratio.x - nCircles.x * 2. * BOX_RADIUS) / 2., (1.0 - nCircles.y * 2. * BOX_RADIUS) / 2.);

    vec4 colorA = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 colorC = vec4(0.5176, 0.0, 1.0, 1.0);
    vec4 colorB = vec4(1.0, 0.5333, 0.0, 1.0);
    vec4 color = vec4(0.2353, 1.0, 0.0, 1.0);
    vec4 resultColorA;
    vec4 resultColorB;
    vec4 resultColor;
    
    float current_circle;
    float circles;
    float circleStrokes;
    float percentage;
    float radius;

    circles = drawCircles(coord, nCircles, margin, 1, 1);
    circleStrokes = stroke(circles, .002, 0.05, 0.05);
    resultColorA = mix(colorA, colorB, circleStrokes);

    circles = drawCircles(coord, nCircles, margin, 3, 1);
    circleStrokes = stroke(circles, 0.03, 0.005, 0.05);
    resultColorB = mix(colorA, colorC, circleStrokes);

    resultColor = mix(resultColorA, resultColorB, 0.5);

    gl_FragColor=resultColor;
}
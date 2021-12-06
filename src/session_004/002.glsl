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
    vec4 colorB = vec4(0.5176, 0.0, 1.0, 1.0);
    vec4 colorC = vec4(0.2353, 1.0, 0.0, 1.0);
    vec4 colorD = vec4(1.0, 0.5333, 0.0, 1.0);
    vec4 colorE = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 resultColor = colorE;

    float circle_;
    float stroke_;

    vec2 circleBaseSt;
    vec2 circleLeftSt;
    vec2 circleRightBSt;
    vec2 bezierSt;

    float translationValue;

    circleBaseSt = st;
    circleBaseSt = rotateCoord(circleBaseSt, sin(u_time));
    circleLeftSt = st;
    circleRightBSt = st;
    bezierSt = st;

    translationValue = sin(u_time, 1., 0.1, .5);

    circleBaseSt = scaleCoord(circleBaseSt, vec2(1., sin(u_time, 1., 0., 1.)));
    circleLeftSt = circleBaseSt;
    circleRightBSt = circleBaseSt;

    circle_ = circle(circleBaseSt, 0.2);
    stroke_ = stroke(circle_, .002, 0.05, 0.05);
    resultColor = mix(colorA, resultColor, 1. - stroke_);

    circleLeftSt = scaleCoord(circleLeftSt, vec2(1., sin(u_time, 1., 0., 1.)));
    circleLeftSt = translateCoord(circleLeftSt, vec2(translationValue, 0));
    
    circleRightBSt = scaleCoord(circleRightBSt, vec2(1., sin(u_time, 1., 0., 1.)));
    circleRightBSt = translateCoord(circleRightBSt, vec2(-translationValue, 0));

    circle_ = circle(circleLeftSt, 0.2);
    stroke_ = stroke(circle_, .002, 0.05, 0.05);
    resultColor = mix(colorB, resultColor, 1. - stroke_);

    circle_ = circle(circleRightBSt, 0.2);
    stroke_ = stroke(circle_, .002, 0.05, 0.05);
    resultColor = mix(colorB, resultColor, 1. - stroke_);

    circleLeftSt = scaleCoord(circleLeftSt, vec2(1., sin(u_time, 1., 0., 1.)));
    circleLeftSt = translateCoord(circleLeftSt, vec2(translationValue, 0));
    
    circleRightBSt = scaleCoord(circleRightBSt, vec2(1., sin(u_time, 1., 0., 1.)));
    circleRightBSt = translateCoord(circleRightBSt, vec2(-translationValue, 0));

    circle_ = circle(circleLeftSt, 0.2);
    stroke_ = stroke(circle_, .002, 0.05, 0.05);
    resultColor = mix(colorB, resultColor, 1. - stroke_);

    circle_ = circle(circleRightBSt, 0.2);
    stroke_ = stroke(circle_, .002, 0.05, 0.05);
    resultColor = mix(colorB, resultColor, 1. - stroke_);

    gl_FragColor=resultColor;
}
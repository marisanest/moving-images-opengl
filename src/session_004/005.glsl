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
    vec4 colorResult = colorE;

    float strokeResult;
    
    float bezierA;
    float bezierB;
    float bezierC;
    float bezierResult;
    
    
    vec2 bezierASt = st;
    vec2 bezierBSt = st;
    vec2 bezierCSt = st;

    bezierASt = translateCoord(bezierASt, vec2(-0.2, cos(u_time, 1.0, -.5, -0.15)));
    bezierASt = scaleCoord(bezierASt, vec2(0.8, 0.8));
    bezierA = sdBezier(bezierASt, vec2(.0, .0), vec2(.0, .0), vec2(.0, sin(u_time, 1.0, 0.0, 0.1)));
    
    bezierBSt = translateCoord(bezierBSt, vec2(0.2, cos(u_time, 1.0, -.5, -0.15)));
    bezierBSt = scaleCoord(bezierBSt, vec2(0.8, 0.8));
    bezierB = sdBezier(bezierBSt, vec2(.0, .0), vec2(.0, .0), vec2(.0, sin(u_time, 1.0, 0.0, 0.1)));
    
    bezierResult = merge(bezierA, bezierB);

    bezierCSt = translateCoord(bezierCSt, vec2(0.0, sin(u_time, 1.0, 0.15, 0.5)));
    bezierC = sdBezier(
        bezierCSt, 
        vec2(-.4, .0), 
        vec2(.0, cos(u_time, 1.0, -0.5, 0.5)), 
        vec2(0.4, .0)
        );
    
    bezierResult = merge(bezierResult, bezierC);

    strokeResult = stroke(bezierResult, .003, 0.2, 0.2);
    colorResult = mix(colorA, colorResult, 1. - strokeResult);

    gl_FragColor=colorResult;
}
#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;


#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/circle-line.glsl"


float hash(vec2 p){
    p = fract(p * vec2(234.34, 435.345));
    p += dot(p, p + 34.23);
    return fract(p.x * p.y);
}

float smileyMouth(vec2 coord) {
    return sdBezier(
        coord, 
        vec2(-.4, -.15), 
        vec2(.0, -0.65), 
        vec2(0.4, -.15)
    );
}

float smileyEye(vec2 coord) {
    return sdBezier(
        coord, 
        vec2(0., .05), 
        vec2(0., .05), 
        vec2(0., -.05)
    );
}

vec4 object1(vec2 st, vec4 color, vec4 backgroundColor) {
    vec2 fistMouthSt = translateCoord(st, vec2(-(u_resolution.x / u_resolution.y), 0.0));
    float firstMouth = smileyMouth(fistMouthSt);

    vec2 secondMouthSt = translateCoord(st, vec2((u_resolution.x / u_resolution.y), 0.0));
    secondMouthSt = rotateCoord(secondMouthSt, PI);
    float secondMouth = smileyMouth(secondMouthSt);

    float mouths = merge(firstMouth, secondMouth);
    
    mouths = 1. - stroke(mouths, 0.002, 0.2);
    
    vec4 currentColor = mix(color, backgroundColor, mouths);

    return currentColor;
}

vec4 object2(vec2 st, vec4 color, vec4 backgroundColor) {
    vec2 firstEyeSt = translateCoord(st, vec2(-(u_resolution.x / u_resolution.y) + 0.2, 0.0));
    float firstEye = smileyEye(firstEyeSt);

    vec2 secondEyeSt = translateCoord(st, vec2((u_resolution.x / u_resolution.y) - 0.2, 0.0));
    float secondEye = smileyEye(secondEyeSt);
    
    float eyes = merge(firstEye, secondEye);
    eyes = 1. - stroke(eyes, 0.002, 0.2);
    
    vec4 currentColor = mix(color, backgroundColor, eyes);

    return currentColor;
}

void main(void){
    vec2 st = setupCoord(gl_FragCoord.xy, u_resolution.xy);
    vec4 currentColor = object1(st, LILA, WHITE);

    gl_FragColor=currentColor;
}
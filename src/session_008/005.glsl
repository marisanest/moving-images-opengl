#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_tex0;
uniform float u_time;
uniform vec2 u_resolution;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/colors.glsl"

void main(){
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution.xy);

    vec2 circleACoord = coord;
    vec2 circleBCoord = coord;

    float circleA = circle(circleACoord, 0.3);

    
    circleBCoord = translateCoord(circleBCoord, vec2(adjustedSin(u_time, .8, -0.2, 0.2), 0.));
    float circleB = circle(circleBCoord, 0.3);

    float moon = subtract(circleB, circleA);
    //moon = fill(moon, 0.001);
    moon = 1. - stroke(moon, 0.0004, 0.01);

    vec4 result = mix(WHITE, BLACK, moon);

    gl_FragColor = (result);
}
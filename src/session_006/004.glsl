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
#include "../libs/local/smiley.glsl"

void main(void) {
    vec2 st = setupCoord(gl_FragCoord.xy, u_resolution.xy);

    vec4 colorBg = BLACK;

    vec2 layerA = st;
    layerA = scaleCoord(layerA, vec2(4.));
    layerA = fract(layerA);
    layerA = translateCoord(layerA, vec2(-.5));
    layerA = scaleCoord(layerA, vec2(1.5));
    layerA = translateCoord(layerA, vec2(adjustedSin(u_time, 1.0, -0.08, 0.08), adjustedCos(u_time, 1.0, -0.08, 0.08)));

    colorBg = smiley(layerA, WHITE, colorBg, false);

    vec2 layerB = st;
    layerB = scaleCoord(layerB, vec2(1.));;
    layerB = fract(layerB);
    layerB = translateCoord(layerB, vec2(-.5));
    layerB = scaleCoord(layerB, vec2(1.5));
    layerB = translateCoord(layerB, vec2(adjustedSin(u_time, 1.0, -0.06, 0.06), adjustedCos(u_time, 1.0, -0.06, 0.06)));

    colorBg = smiley(layerB, LILA, colorBg, false);

    gl_FragColor = colorBg;
}
#ifdef GL_ES 
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/smiley.glsl"
#include "../libs/local/circle-line.glsl"

void main() {
    vec2 st = normalizeCoord(gl_FragCoord.xy, u_resolution);
    st = fixCoordRatio(st, u_resolution);

    st = scaleCoord(st, vec2(4., 4.));
    st = rotateCoord(st, adjustedSin(u_time, 0.25, -1., 1.) * 0.25 * M_PI);
    st = translateCoord(st, vec2(step(1.0, mod(st.y, 2.0)) * 0.5, 0.0));

    float stepX = step(1.0, mod(st.x, 2.0));
    float stepY = step(1.0, mod(st.y, 2.0));

    st = fract(st);
    vec2 smileySt = st;

    smileySt = translateCoord(smileySt, vec2(-0.5));
    smileySt = scaleCoord(smileySt, vec2(adjustedSin(u_time, 1.0, 1.5, 3.0)));
    smileySt = rotateCoord(smileySt, sin(u_time + stepY * M_PI));

    vec4 currentColor = BLACK;
    vec4 smileyColor = WHITE;

    if (stepX == 0. || stepY == 0.) {
        smileyColor = LILA; 
    }

    currentColor = smiley(smileySt, smileyColor, currentColor, false);

    gl_FragColor = currentColor;
}
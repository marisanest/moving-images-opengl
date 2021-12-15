#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/math.glsl"

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution.xy);
    vec4 backgroundColor = BLACK;

    float shape = step(coord.x, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(WHITE, backgroundColor, shape);

    gl_FragColor = backgroundColor;
}
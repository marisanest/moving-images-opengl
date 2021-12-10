#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    
    vec2 layer1 = scaleCoord(coord, vec2(2., 4.));
    layer1.x *= adjustedSin(u_time + layer1.y * 10., 1.0, 0., 0.1) + layer1.y;
    layer1.y *= adjustedSin(u_time + layer1.x * 10., 2.0, 0., 0.1) + layer1.x;
    layer1 = fract(layer1);

    vec4 texel = texture2D(u_tex0, layer1);
    float circle1 = circle(rotateCoord(layer1, sin(u_time) * PI), 0.1);
    vec4 currentColor = mix(BLACK, texel, circle1);

    gl_FragColor = currentColor;
}
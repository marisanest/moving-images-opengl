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
    vec4 backgroundColor = BLACK;
    
    vec2 layer1 = scaleCoord(coord, vec2(2.));
    layer1.x *= adjustedSin(u_time + layer1.y * 10., 1.0, 0., 0.1) + layer1.y;
    layer1.y *= adjustedSin(u_time + layer1.x * 10., 2.0, 0., 0.1) + layer1.x;
    layer1 = fract(layer1);
    vec4 texel = texture2D(u_tex0, layer1);
    
    vec2 layer2 = coord;
    layer2 = scaleCoord(layer2, vec2(4.));
    layer2.x *= adjustedSin(u_time + layer2.y * 10., 1.0, 0., 0.1) + layer2.y;
    layer2.y *= adjustedSin(u_time + layer2.x * 10., 2.0, 0., 0.1) + layer2.x;
    layer2 = fract(layer2);
    layer2 = translateCoord(layer2, vec2(-.5));
    
    float circle2 = circle(layer2, 0.1);
    circle2 = fill(circle2, 0.1);

    backgroundColor = mix(texel, backgroundColor, circle2);

    float circle3 = circle(layer2, 0.05);
    circle3 = fill(circle3, 0.02);
    backgroundColor = mix(BLACK, backgroundColor, circle3);

    vec2 layer3 = coord;
    
    layer3 = scaleCoord(layer3, vec2(2.));

    layer3.x *= adjustedSin(u_time + layer3.y * 10., 1.0, 0., 0.3) + layer3.y;
    layer3.y *= adjustedSin(u_time + layer3.x * 10., 2.0, 0., 0.3) + layer3.x;

    layer3 = fract(layer3);
    layer3 = translateCoord(layer3, vec2(-.5));
    
    float circle4 = circle(layer3, 0.3);
    circle4 = fill(circle4, 0.1);

    backgroundColor = mix(texel, backgroundColor, circle4);

    float circle5 = circle(layer3, 0.1);
    circle5 = fill(circle5, 0.02);
    backgroundColor = mix(BLACK, backgroundColor, circle5);

    gl_FragColor = backgroundColor;
}
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/math.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/style.glsl"

vec4 wave(vec2 coord, vec4 backgroundColor, float width) {
    float shapeA = step(coord.x, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(WHITE, backgroundColor, shapeA);

    float shapeB = step(coord.x - width, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(BLACK, backgroundColor, shapeB);
    
    return backgroundColor;
}

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution.xy);
    vec4 backgroundColor = BLACK;

    float shapeE = step(coord.x + 0.4, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(WHITE, backgroundColor, shapeE);

    float shapeF = step(coord.x + 0.2, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(BLACK, backgroundColor, shapeF);

    float shapeA = step(coord.x, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(WHITE, backgroundColor, shapeA);

    float shapeB = step(coord.x - 0.2, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(BLACK, backgroundColor, shapeB);

    float shapeC = step(coord.x - 0.4, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(WHITE, backgroundColor, shapeC);

    float shapeD = step(coord.x - 0.6, adjustedSin(coord.y, 2.4, 0.5, -0.5));
    backgroundColor = mix(BLACK, backgroundColor, shapeD);

    gl_FragColor = backgroundColor;
}
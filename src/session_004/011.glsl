#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/colors.glsl"

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution);

    coord *= 2.0;
    coord = fract(coord);
    coord -= 0.5;
    coord *= coord;

    vec4 backgroundColor = WHITE;

    vec2 circleCoord = coord;
    float circleShape = circle(circleCoord, 0.2);
    float circleStroke = stroke(circleShape, .002, 0.05, 0.05);
    
    backgroundColor = mix(BLACK, backgroundColor, circleStroke);

    gl_FragColor = backgroundColor;
}
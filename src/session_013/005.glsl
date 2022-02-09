#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/random.glsl"
#include "../libs/local/colors.glsl"
#include "../libs/local/style.glsl"

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution);
    vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 currentColor = black;

    float shape = sdBezier(
        coord, 
        vec2(.0, adjustedCos(u_time + .5 * snoise(coord + u_time), 1.0, -.1, 0.0)), 
        vec2(.0, .0), 
        vec2(.0, adjustedSin(u_time + 1.2 * snoise(coord + u_time), 1.0, 0.0, 0.1))
    );
    
    shape = sdBezier(
         coord, 
         vec2(-.4, .0), 
        vec2(.0, adjustedCos(u_time + 1.2 * snoise(coord + u_time), 1.0, -0.5, 0.3)), 
        vec2(0.4, .0)
    );

    shape = stroke(shape, .003, 0.2, 0.2);

    currentColor = mix(BLACK, WHITE, shape);

    gl_FragColor = currentColor;
}
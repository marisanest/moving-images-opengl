#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/edap/2dshapes.glsl"
#include "../libs/edap/boolean-ops.glsl"

void main() {
    float radius = 0.05;
    float thikness = 0.01;
    float outer_radius = radius + thikness / 2.;

    float ratio_x = u_resolution.x / u_resolution.y;
    float ratio_y = u_resolution.y / u_resolution.x;

    // why do we need to substract here?
    float x = (gl_FragCoord.x - (0. * u_resolution.x / 2.)) / u_resolution.x - (outer_radius * ratio_y);
    x *= ratio_x;
    float y = (gl_FragCoord.y - (u_resolution.y)) / u_resolution.y + outer_radius;

    vec2 coord = vec2(x, y);
   
    vec4 colorA = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 colorB = vec4(0.6, 0.0, 1.0, 1.0);
    vec4 colorC = vec4(0.3098, 0.5961, 0.6471, 1.0);

    // negative if in circle else positive ?
    float circle = circle(coord, radius);
    float result = stroke(circle, 0.0, thikness);

    vec4 color = mix(colorA, colorB, result);

    gl_FragColor=color;
}
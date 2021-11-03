#ifdef GL_ES
precision mediump float;
#endif

#include "./libs/2d_shapes.glsl"

uniform vec2 u_resolution;
uniform float u_time;

void main(){
    vec2 coord = 2.0 * gl_FragCoord.xy / u_resolution - 1.0;
    coord.x *= u_resolution.x / u_resolution.y;

    float min_side = .2;
    float max_side = .5;
    float frequency = 1.;
    float side_x = (abs(cos(u_time * frequency)) * max_side) + min_side;
    float side_y = (abs(sin(u_time * frequency)) * max_side) + min_side;

    if (isWithinBox(coord, vec2(side_x, side_y))) {
        gl_FragColor=vec4(1.0, 1.0, 1.0, 1.0);
    } else {
        gl_FragColor=vec4(1.0, 0.0, 0.0, 1.0);
  };
}
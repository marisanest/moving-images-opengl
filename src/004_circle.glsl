#ifdef GL_ES
precision mediump float;
#endif

#include "./libs/2d_shapes.glsl"

uniform vec2 u_resolution;
uniform float u_time;

void main(){
    vec2 coord = 2. * gl_FragCoord.xy / u_resolution - 1.0;
    coord.x *= u_resolution.x / u_resolution.y;
    
    vec4 result;
    vec4 color_a = vec4(0.149, 0.1294, 0.4314, 1.0);
    vec4 color_b = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 color_c = vec4(0.0, 0.0, 1.0, 1.0);
    vec4 color_d = vec4(0.6549, 0.0588, 0.6549, 1.0);
   
    float circel_a = distanceCircleBordertoOutside(coord, .1);
    result = mix(color_a, color_b, circel_a);

    float circel_b = distanceCircleBordertoOutside(coord + vec2(((abs(cos(u_time * .5)) * 1.) + 1.), 1.), 0.1);
    result = mix(color_c, result, circel_b);

    float circel_c = distanceCircleBordertoOutside(coord + vec2(-1., -1.), 0.1);
    result = mix(color_d, result, circel_c);

    gl_FragColor = result;
}
#ifdef GL_ES
precision mediump float;
#endif

#include "../libs/local/2d_shapes.glsl"

uniform vec2 u_resolution;
uniform float u_time;

void main(){
    vec2 coord = 2. * gl_FragCoord.xy / u_resolution - 1.0;
    coord.x *= u_resolution.x / u_resolution.y;
    
    // question: how to mix these circles without this vanishing effect?

    vec4 result;
    vec4 color_a = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 color_b = vec4(1.0, 0.0, 0.0, 1.0);
    
    float circel_a = distance_circle_border_to_circle_center(coord + vec2((((cos(u_time * .5)) * .6)), (((sin(u_time * .6)) * .5))), 0.6, 0.0);
    vec4 result_a = mix(color_a, color_b, circel_a);
    result = result_a;

    float circel_b = distance_circle_border_to_circle_center(coord + vec2((((sin(u_time * .5)) * .6)), (((cos(u_time * .6)) * .5))), 0.6, 0.0);
    vec4 result_b = mix(color_a, color_b, circel_b);
    result = mix(result, result_b, 0.5);
    
    float circel_c = distance_circle_border_to_circle_center(coord + vec2(-1., -1.), 0.1, 0.0);
    vec4 result_c = mix(color_a, color_b, circel_c);
    result = mix(result, result_c, 0.5);

    gl_FragColor = result;
}
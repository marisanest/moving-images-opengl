#ifdef GL_ES
precision mediump float;
#endif

#include "../libs/local/2dshapes.glsl"

uniform vec2 u_resolution;
uniform float u_time;

void main(){
    vec2 coord = 2. * gl_FragCoord.xy / u_resolution - 1.0;
    coord.x *= u_resolution.x / u_resolution.y;
    
    vec4 color_a = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 color_b = vec4(1.0, 0.0, 0.0, 1.0);
   
    float circel_a = distance_circle_border_to_outside(
        coord, 
        abs(cos(u_time * .5)),
        abs(cos(u_time * .5))
    );

    vec4 result = mix(color_a, color_b, circel_a);

    for(int i = 0; i < 0; ++i){
        float circel_b = distance_circle_border_to_outside(
            coord, 
            abs(cos(u_time * (float(i) + 1.) * .2)),
            abs(cos(u_time * .5))
        );

        vec4 result_b = mix(color_a, color_b, circel_b);
        result = mix(result, result_b, 0.5);
    }

    gl_FragColor = result;
}
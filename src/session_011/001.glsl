#ifdef GL_ES
precision mediump float;
#endif


uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/math.glsl"



float rand(vec2 st){
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) *
    43758.5453123);
}

float rand2(vec2 st){
    // vec2(123434.1322, 234332.2)
    return mod(sin(
        st.x * (12914373.1) + 
        st.y * (12914373.1)) * 87458.43, 1.0);
}

void main(){

    vec2 st = gl_FragCoord.xy / u_resolution;
    float c = st.x;

    c = rand2(st);

    gl_FragColor = vec4(vec3(c), 1.0);
} 
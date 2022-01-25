// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( random( i + vec2(0.0,0.0) ),
                     random( i + vec2(1.0,0.0) ), u.x),
                mix( random( i + vec2(0.0,1.0) ),
                     random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 rotate2d(float angle){
    return mat2(cos(angle),-sin(angle),
                sin(angle),cos(angle));
}

float lines(vec2 st, float b){
    return smoothstep(0.0, .5 + b * .5, abs((sin(st.x * 3.1415) + b * 2.0)) * .5);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.y *= u_resolution.y / u_resolution.x;

    st.xy *= vec2(3.,10.);
    float pattern = st.x;

    // Add noise
    st *= rotate2d(noise(st));

    // Draw lines
    st.xy *= vec2(10.,10.);
    pattern = lines(st, 0.5);

    gl_FragColor = vec4(vec3(pattern), 1.0);
}

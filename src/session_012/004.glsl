// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#include "../libs/local/random.glsl"
#include "../libs/local/coord-ops.glsl"

mat2 rotate2d(float angle){
    return mat2(cos(angle),-sin(angle),
                sin(angle),cos(angle));
}

float lines(vec2 st, float b){
    return smoothstep(0.0, .5 + b * .5, abs((sin(st.x * 3.1415) + b * 2.0)) * .5);
}

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    coord = fixCoordRatio(coord, u_resolution);

    coord *= vec2(3.,10.);
    coord *= rotate2d(vnoise(coord));
    coord *= vec2(10.,10.);

    float pattern;
    // pattern = coord.x;
    pattern = lines(coord, 0.5);

    gl_FragColor = vec4(vec3(pattern), 1.0);
}

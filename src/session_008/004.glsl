#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_tex0;
uniform float u_time;
uniform vec2 u_resolution;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/style.glsl"
#include "../libs/local/colors.glsl"

void main(){
    vec2 st = 2.*gl_FragCoord.xy/u_resolution - 1.;
    st.x*= u_resolution.x/u_resolution.y;

    float circleA = circle(st, 0.3);
    float circleB = circle(st - vec2(0.05), 0.3);
    float twoCircle = subtract(circleB, circleA);
    twoCircle = fill(twoCircle, 0.00001);

    //float twoCircle = fill(circleA, 0.001);
    //twoCircle = fill(twoCircle - circleB, 0.001);

    vec4 result = mix(WHITE, BLACK, twoCircle);

    gl_FragColor = (result);
}
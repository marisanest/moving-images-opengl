#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/coord-ops.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/math.glsl"

float dcircle(vec2 coord, vec2 loc){
    float d = distance(coord, loc);
    float s = smoothstep(0.1, 0.7, d);
    return s;
}

void main () {
    vec4 colorA = vec4(0.0471, 0.3961, 0.4667, .0);
    vec4 colorB = vec4(0.0039, 0.0, 0.0588, .0);
    vec4 colorC = vec4(0.8549, 0.851, 0.9137, .0);

    vec2 st = setupCoord(gl_FragCoord.xy, u_resolution.xy);
    st = scaleCoord(st, vec2(1.2));
    st *= scaleCoord(st, vec2(adjustedSin(u_time, 0.1, -4., 4.)));

    float circleA = dcircle(st, vec2(sin(u_time) * sin(u_time), cos(u_time) * sin(u_time)));
    float circleB = dcircle(st, vec2(cos(u_time) * 0.2, sin(u_time) * 0.2));
    float circleResult = merge(circleA, circleB);
    
    circleResult += length(st) * sin(length(st) * 7. + u_time * 2.);
    circleResult *= rotateCoord(st, u_time * 0.3).y;
    circleResult /= rotateCoord(st, u_time).x;

    vec4 currentColor;
    currentColor = mix(colorA, colorB, circleResult);
    currentColor = mix(colorA, colorC, currentColor);
    
    vec4 result = 0.01 / (currentColor * (length(rotateCoord(st, sin(u_time)).x * (st.y + sin(u_time) + st.x + cos(u_time)))));
    currentColor = vec4(result);

    gl_FragColor = currentColor;
}
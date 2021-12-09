#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/style.glsl"


void main () {
    vec4 colorA = vec4(0.0471, 0.3961, 0.4667, .0);
    vec4 colorB = vec4(0.0039, 0.0, 0.0588, .0);
    vec4 colorC = vec4(0.8549, 0.851, 0.9137, .0);

    vec2 st = setupCoord(gl_FragCoord.xy, u_resolution.xy);
    st = scaleCoord(st, vec2(adjustedSin(u_time, 2.0, 0., 5.)));
    st = st * st;

    vec4 currentColor = mix(colorA, colorB, vec4(1.));
    
    gl_FragColor = vec4(st, 0.0, 1.0);

    return;

    vec2 circleASt = translateCoord(st, vec2(adjustedSin(u_time, 2.0, -1., 0.), adjustedCos(u_time, 2.0, -.5, .5)));
    float circleA = circle(circleASt, 0.4);

    vec2 circleBSt = translateCoord(st, vec2(adjustedSin(u_time, 1.0, -.2, .2), adjustedCos(u_time, 1.0, -.2, .2)));
    float circleB = circle(circleBSt, 0.4);

    float circleResult = merge(circleA, circleB);
    circleResult = circleA;
    circleResult = fill(circleResult, 0.2);
    //vec4 currentColor = mix(colorA, colorB, circleResult);

    circleResult += length(st) * sin(length(st) * 7. + u_time * 2.);
    circleResult *= rotateCoord(st, u_time * 0.3).y;
    circleResult /= rotateCoord(st, u_time).x;

    //vec4 currentColor;
    currentColor = mix(colorA, colorB, circleResult);
    currentColor = mix(colorA, colorC, currentColor);
    
    vec4 result = 0.01 / (currentColor * (length(rotateCoord(st, sin(u_time)).x * (st.y + sin(u_time) + st.x + cos(u_time)))));
    currentColor = vec4(result);
   
    gl_FragColor = currentColor;
}
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/style.glsl"

void main() {
    vec2 coord = 2.0 * gl_FragCoord.xy / u_resolution.xy - 1.0;
    coord.x *= u_resolution.x / u_resolution.y;

    vec4 colorA = vec4(0.7333, 0.3294, 0.3294, 1.0);
    vec4 colorB = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 colorC = vec4(0.3098, 0.5961, 0.6471, 1.0);

    float circleA = circle(coord + vec2(cos(0.8 * (u_time + PI)), cos(.8 * (u_time + PI))), 0.5);
    float circleB = circle(coord + vec2(cos(0.5 * u_time), cos(0.5 * u_time)), 0.5);
    float circleC = circle(coord + vec2(sin(0.4 * u_time + PI), -sin(0.4 * u_time + PI)), 0.5);
    float circleD = circle(coord + vec2(sin(0.6 * u_time), -sin(0.6 * u_time)), 0.5);
     
    float resultA = mergeExclude(circleA, circleB);
    float resultB = mergeExclude(circleC, circleD);
    float result = mergeExclude(resultA, resultB);
    //result = mergeExclude(result, bezier);
    
    float percentage = ((sin(u_time) + 1.) / 2.) * 0.1 + 0.02;
    result = stroke(result, percentage, 0.07);
    
    vec4 color = mix(colorC, colorA, result);
    float bezier = sdBezier(coord, vec2(sin(u_time), 0.), vec2(-((cos(u_time) + 1.) / 2.), 0.2), vec2(0.6, -cos(u_time)));

    float bezierResult = stroke(bezier, 0.03, 0.04);
    color = mix(color, colorB, -bezier);

    gl_FragColor=color;
    
}
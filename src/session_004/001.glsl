#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/style.glsl"
#include "../libs/local/boolean-ops.glsl"
#include "../libs/local/2dshapes.glsl"

float box2(vec2 p, vec2 b)
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

vec2 fixRatio(vec2 monitorResolution) {
    vec2 fixedRatio = 2.0 * gl_FragCoord.xy / monitorResolution.xy - 1.0;
    //vec2 fixedRatio = gl_FragCoord.xy / monitorResolution.xy;
    fixedRatio.x *= monitorResolution.x / monitorResolution.y;

    return fixedRatio;
}

mat2 rotate2d(float angle) {
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

mat2 scale(vec2 s) {
    return mat2(s.x, 0.0, 0.0, s.y);
}

vec4 merge(vec4 c1, vec4 c2){
	return c1;
}

void main() {
    vec2 st = fixRatio(u_resolution);

    vec4 colorA = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 colorB = vec4(0.0, 1.0, 0.0, 1.0);
    vec4 colorC = vec4(0.0, 0.0, 1.0, 1.0);

    vec2 yellowBoxCoord = st;

    vec2 translate = vec2(-0.3, 0.0);
    //st += translate;
    
    st = rotate2d(sin(u_time) * M_PI) * st;
    float boxA = box2(st, vec2(0.25, 0.25));
    boxA = fill(boxA, 0.0);

    vec4 colorBox = mix(colorC, colorA, boxA);
    
    st = scale(vec2(sin(u_time))) * st;
    float circleA = circle(st, 0.2);
    circleA = fill(circleA, 0.);

    //vec4 colorCircle = mix(colorB, colorC, circleA);

    //vec4 color = mix(colorB, colorA, merge(boxA, circleA));
    vec4 color = mix(colorB, colorBox, circleA);
    //vec4 color = merge(colorCircle, colorBox);


    gl_FragColor=color;
}
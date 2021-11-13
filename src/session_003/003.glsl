#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/2dshapes.glsl"
#include "../libs/local/style.glsl"

void main(){
    vec2 coord = 2.0 * gl_FragCoord.xy / u_resolution.xy - 1.0;
    coord.x *= u_resolution.x / u_resolution.y;

    vec4 colorA = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 colorB = vec4(1.0, 0.0, 0.0, 1.0);

    float circleA = circle(coord - vec2(0.4, 0.4), 0.1);
    float circleB = circle(coord + vec2(0.4, 0.4), 0.1);
    
    float percentage; 
    //percentage = coord.x, 0.5;
    //percentage = mod(coord.x, 0.5);
    percentage = fract(coord.x);

    float line = plot(coord, percentage);
    vec4 color = mix(colorA, colorB, line);

    gl_FragColor=color;
    
}
#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/math.glsl"

void main() {
    vec2 uv = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    vec2 p = setupCoord(gl_FragCoord.xy, u_resolution.xy);
		
    float l = length(p) * .1;

    vec2 value = (p * p * p) / l * adjustedSin(u_time, 1.0, 1.0, 2.0) * adjustedSin(l * 10. - 2. * u_time, 1.0, 0.0, 1.0);
    //uv = value;
    uv.x += adjustedSin(u_time, 1.0, 0.0, 2.0) * value.x;
    //uv.y += adjustedSin(u_time + PI, 1.0, 0.0, 2.0) * value.y;

    //uv = scaleCoord(uv, vec2(1.2));
    uv = fract(uv);
    uv = translateCoord(uv, vec2(-.5));
    
    float shape = length(uv);
    shape = .03 / shape;
    
    vec4 backgroundColor = mix(WHITE, LILA, shape);
    //vec4 backgroundColor = vec4(vec3(shape), 1.0);
    
	gl_FragColor = backgroundColor;
}
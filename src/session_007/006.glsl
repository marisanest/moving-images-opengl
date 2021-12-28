#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/math.glsl"

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    vec2 p = setupCoord(gl_FragCoord.xy, u_resolution.xy);
		
    float l = length(p) * .1;

    //p = translateCoord(p, vec2(adjustedSin(u_time, 1.0, -0.1, .1), adjustedCos(u_time, 1.0, -0.1, .1)));

    vec2 value = (p * p * p) / l * adjustedSin(u_time, 1.0, 1.0, 2.0) * adjustedSin(l * 10. - 2. * u_time, 1.0, 0.0, 1.0);
    //coord = value;
    coord = translateCoord(coord, vec2(adjustedCos(u_time, 0.5, -2.0, 2.0)));
    coord += value;

    //coord = scaleCoord(coord, vec2(1.2));
    coord = fract(coord);
    coord = translateCoord(coord, vec2(-.5));
    
    float shape = length(coord);
    shape = .03 / shape;
    
    vec4 backgroundColor = mix(BLACK, WHITE, shape);
    //vec4 backgroundColor = vec4(vec3(shape), 1.0);
    
	gl_FragColor = backgroundColor;
}
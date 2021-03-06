#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform sampler2D u_tex0;

#include "../libs/local/colors.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/math.glsl"

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    vec2 p = setupCoord(gl_FragCoord.xy, u_resolution.xy);
		
    float l = length(p);

    vec2 value = (p * p) / l * adjustedSin(u_time, 1.0, 1.0, 2.0) * adjustedSin(l * 10. - 2. * u_time, 1.0, 0.0, 1.0);
    coord += value;
    coord *= coord;
    
    //uv = scaleCoord(uv, vec2(1.2));
    coord = fract(coord);
    coord = translateCoord(coord, vec2(-.5));
    
    float shape = length(coord);
    shape = .03 / shape;
    
    //vec4 texel = texture2D(u_tex0, coord);
    //vec4 backgroundColor = mix(texel, LILA, shape);
    vec4 backgroundColor = vec4(vec3(shape), 1.0);
    
	gl_FragColor = backgroundColor;
}
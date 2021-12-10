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
    vec2 coord = gl_FragCoord.xy;
    
	float color;
	float l;
    vec2 uv, p;

    uv = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    p = setupCoord(gl_FragCoord.xy, u_resolution.xy);
		
    l = length(p);

    p *= p;
    uv += p / l * adjustedSin(u_time, 1.0, .0, 1.0) * adjustedSin(l * 10. - 2. * u_time, 1.0, 2.0, 2.0);
	uv *= uv;
    uv = scaleCoord(uv, vec2(1.2));
    uv = fract(uv);
    uv.x = uv.y;
    color = .02 / length(mod(uv, 1.) - .5);
    
    vec4 texel = texture2D(u_tex0, coord);
    vec4 backgroundColor = mix(texel, LILA, color);
    backgroundColor = vec4(vec3(color), 1.0);
    
	gl_FragColor = backgroundColor;
}
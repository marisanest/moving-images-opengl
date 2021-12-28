#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/coord-ops.glsl"
#include "../libs/local/colors.glsl"

float noise( vec2 p )
{
	return sin(p.x)*sin(p.y);
}

float fbm( vec2 p )
{
    float f = 0.0;
    mat2 m = mat2( 0.80,  0.60, -0.60,  0.80 );
    f += 0.5000*noise( p ); p = m*p*2.02;
    f += 0.2500*noise( p ); p = m*p*2.03;
    f += 0.1250*noise( p ); p = m*p*2.01;
    f += 0.0625*noise( p );
    return f/0.9375;
}

float pattern( vec2 p )
{
    vec2 q = vec2(fbm(p));

    return fbm(p + 4.0 * q );
}

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution.xy);

    gl_FragColor = mix(BLACK, WHITE, pattern(coord));
}
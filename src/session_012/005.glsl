#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/random.glsl"
#include "../libs/local/coord-ops.glsl"

void main() {
    vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    coord = fixCoordRatio(coord.xy, u_resolution.xy);
    coord += gnoise(coord * 2.);

    float color = 0.0;
    color += smoothstep(.18, .2, gnoise(coord)); // Big black drops
    color += smoothstep(.15, .2, gnoise(coord * 10.)); // Black splatter
    color -= smoothstep(.35, .4, gnoise(coord * 10.)); // Holes on splatter
    //color += 10. * smoothstep(.4, .7, noise(st * 10.));
    //color += smoothstep(.18, .2, noise(st)); // Big black drops
    //color -= 10. * smoothstep(.5, 1., noise(st * 10.));

    gl_FragColor = vec4(vec3(1.-color), 1.0);
}

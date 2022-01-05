#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/local/coord-ops.glsl"
#include "../libs/local/colors.glsl"
#include "../libs/local/math.glsl"
#include "../libs/local/boolean-ops.glsl"


float noise(vec2 p){
	return sin(p.x) * sin(p.y);
}

float fbm(vec2 coord){
    float f = 0.0;
    mat2 m = mat2(cos(0.65), sin(0.65), -sin(0.65), cos(0.65)) * 2.2; //adjustedSin(u_time, 0.5, 2.0, 2.2);

    f += 0.5 * noise(coord); 
    
    coord *= m;
    f += 0.25 * noise(coord);
    
    coord *= m;
    f += 0.125 * noise(coord); 
    
    coord *= m * 100.; // * 1.
    f += 0.0625 * noise(coord);
    
    return f;
}

float pattern(vec2 coord){
    return fbm(
        coord 
        + adjustedSin(u_time, 0.5, 5.0, 20.)
        * fbm(coord + 4.0 
            * fbm(coord + 4.0 
                //* fbm(coord + 4.0 
                    * fbm(coord + 1.0)
                //)
            )
        )
    ) * 1.3;
}

void main() {
    vec2 coord = setupCoord(gl_FragCoord.xy, u_resolution.xy);
    gl_FragColor = mix(vec4(0.4471, 0.1412, 0.7333, 1.0), GREEN, pattern(coord));
}
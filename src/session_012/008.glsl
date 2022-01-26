// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

#ifdef GL_ES
precision mediump float;
#endif

#include "../libs/local/random.glsl"
#include "../libs/local/coord-ops.glsl"
#include "../libs/local/math.glsl"

uniform vec2 u_resolution;
uniform float u_time;

float shape(vec2 st, int N){
    st = st*2.-1.;
    float a = atan(st.x,st.y)+PI;
    float r = TWO_PI/float(N);
    return cos(floor(.5+a/r)*r-a)*length(st);
}

float box(vec2 st, vec2 size){
    return shape(st*size,4);
}

float hex(vec2 st, bool a, bool b, bool c, bool d, bool e, bool f){
    st = st*vec2(2.,6.);

    vec2 fpos = fract(st);
    vec2 ipos = floor(st);

    if (ipos.x == 1.0) fpos.x = 1.-fpos.x;
    if (ipos.y < 1.0){
        return a? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 2.0){
        return b? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 3.0){
        return c? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 4.0){
        return d? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 5.0){
        return e? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 6.0){
        return f? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    }
    return 0.0;
}

float hex(vec2 st, float N){
    bool b[6];
    float remain = floor(mod(N,64.));
    for(int i = 0; i < 6; i++){
        b[i] = mod(remain,2.)==1.?true:false;
        remain = ceil(remain/2.);
    }
    return hex(st,b[0],b[1],b[2],b[3],b[4],b[5]);
}

void main(){
	vec2 coord = normalizeCoord(gl_FragCoord.xy, u_resolution.xy);
    coord = fixCoordRatio(coord.yx, u_resolution.yx).yx;

    float t = u_time * 0.5;

    float df = 1.0;
    //df = mix(hex(coord, t), hex(coord, t + 1.), fract(t));
    //df += snoise(vec3(coord * 75., t * 0.1)) * 0.03;
	df = hex(coord, t);
    float color = mix(0., 1., step(0.7, df));

    gl_FragColor = vec4(vec3(color), 1.0);
}

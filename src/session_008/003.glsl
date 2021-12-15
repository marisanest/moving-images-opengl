#ifdef GL_ES
precision mediump float;
#endif


uniform vec2 u_resolution;
uniform float u_time;


void main(){
vec2 st = 2. * gl_FragCoord.xy/u_resolution.xy - 1.;
st.x *= u_resolution.x/u_resolution.y;
st *= 5.;
vec3 col = vec3(0.);

st.x += sin(st.y * 5.) * 0.5;
if(mod(floor(st.x), 2.) == 0.){
col = vec3(1.);
}


gl_FragColor = vec4(col, 1.);
}
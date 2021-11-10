#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;


void main(){
    vec2 coord = gl_FragCoord.xy / u_resolution;
    //vec2 coord = 2. * gl_FragCoord.xy / u_resolution - 1.;
    //coord.x *= u_resolution.x / u_resolution.y;

    vec4 red = vec4(1., 0., 0., 1.);
    vec4 blue = vec4(0., 0., 1., 1.);
    
    
    //float percantage = coord.x;
    //float percantage = sin(u_time);
    //float percantage = step(sin(u_time), coord.x);
    float percantage = smoothstep(sin(u_time), 1., coord.x);
    vec4 color = mix(red, blue, percantage);
    
    gl_FragColor = color;
}
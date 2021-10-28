#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
float n_quares = 40.;

bool isSquare(vec2 squareSize) {
    vec2 tmp = gl_FragCoord.xy / squareSize;
    return (mod(floor(tmp.x), 2.) == 0. && mod(floor(tmp.y), 2.) == 0.) 
        || (mod(floor(tmp.x), 2.) == 1. && mod(floor(tmp.y), 2.) == 1.);
}

void main(){
    vec2 squareSize = u_resolution / n_quares;
    
    float amplification = abs(sin(u_time * 1.)) * .8 + .1;
    float frequenz = abs(cos(u_time * 2.)) * 2.;

    float red = 1.;
    float green = 0.;
    float blue = 0.;
    float white = 1.;
    float opacity = 1.;

    vec2 coord = gl_FragCoord.xy / u_resolution;

    if (isSquare(squareSize)) {
        white = abs(sin((coord.x - coord.y) * frequenz)) * amplification;
        //white = (coord.x + coord.y) / 2.;
        //white = coord.x;
        gl_FragColor=vec4(white);
    } else {
        //red = abs(sin(u_time * frequenz)) * amplification;
        red = abs(sin((coord.x + coord.y) * frequenz)) * amplification;
        //red = coord.x;
        //red = 1. - (coord.y + coord.x) / 2.;
        gl_FragColor=vec4(red, green, blue, opacity);
  };
}
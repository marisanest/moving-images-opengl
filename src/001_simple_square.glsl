#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
float squareSize = 200.;

bool isSquareV1(vec2 coord) {
    return coord.x >= 0.25 && coord.x <= 0.75 && coord.y >= 0.25 && coord.y <= 0.75; // test also with ^^
}

bool isSquareV2(vec2 coord) {
    vec2 p = (1. - (squareSize / u_resolution)) / 2.;
    return coord.x >= p.x && coord.x <= (1. - p.x) && coord.y >= p.y && coord.y <= (1. - p.y); // test also with ^^
}

void main(){
    float amplification = 1.;
    float frequenz = 100.;
    float red = 1.;
    float green = 0.;
    float blue = 0.;
    float white = 1.;
    float opacity = 1.;

    vec2 coord = gl_FragCoord.xy / u_resolution;

    if (isSquareV2(coord)) {
        //white = abs(sin((coord.x - coord.y) * frequenz)) * amplification;
        //white = (coord.x + coord.y) / 2.;
        //white = coord.x;
        gl_FragColor=vec4(white);
    } else {
        //red = abs(sin(u_time * frequenz)) * amplification;
        //red = abs(sin((coord.x + coord.y) * frequenz)) * amplification;
        //red = coord.x;
        //red = 1. - (coord.y + coord.x) / 2.;
        gl_FragColor=vec4(red, green, blue, opacity);
  };
}
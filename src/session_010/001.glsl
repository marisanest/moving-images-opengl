#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_tex0;
uniform vec2 u_resolution;
varying vec2 v_texcoord;

void main() {
    vec2 texture_size = vec2(576., 720.);
    vec2 step_size = vec2(1.) / texture_size;
    // gl_FragColor = texture2D(u_tex0, gl_FragCoord.xy / u_resolution);
    gl_FragColor = (
        texture2D(u_tex0, v_texcoord + step_size) +
        texture2D(u_tex0, v_texcoord - step_size) +
        texture2D(u_tex0, v_texcoord)
        ) / 3.0 ;
}
#ifdef GL_ES 
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float box(vec2 p,vec2 b ){  
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

float fill(float dist, float size){
    return smoothstep(-size, +size, dist);
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle), sin(_angle),cos(_angle));
}

mat2 scale(vec2 _scale){
    return mat2(_scale.x,0.0, 0.0,_scale.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;

    st *= 4.;
    st.x += step(1.0, mod(st.y, 2.0)) * u_time * 0.5;
     
    st.x += step(1.0, mod(st.y, 2.0)) * 0.5;
    st.x += step(mod(st.y, 2.0), 1.0) * u_time * -0.5;
    st = fract(st);
    
    //st.x += sin(st.y * 7.0) * 0.5;
    //st.x = mod(st.x, 1.); // return x modulo of 0.5
    //st.x = fract(st.x); // return only the fraction part of a number
    //st.x = ceil(x);  // nearest integer that is greater than or equal to x
    //st.x = floor(st.x); // nearest integer less than or equal to x
    //st.x = sign(x);  // extract the sign of x
    //st.x = abs(x);   // return the absolute value of x
    //st.x = clamp(x,0.0,1.0); // constrain x to lie between 0.0 and 1.0
    //st.x = min(st.y, st.x);   // return the lesser of x and 0.0
    //st.x = max(st.y, st.x);   // return the greater of x and 0.0 
    
    vec3 boxColor = vec3(1.0);
    vec3 color = vec3(st, .0);
    
    vec2 boxPos = st - 0.5;
    //boxPos.y += sin((boxPos.x + u_time * 0.6)* 19.0) * 0.1;
    //boxPos = rotate2d(sin(u_time * 1.)) * boxPos;
    //boxPos *= scale(vec2(sin(u_time)));
    float b = box(boxPos, vec2(0.2));
    b = fill(b, 0.);
    color = mix(boxColor, color, b);

    gl_FragColor = vec4(color, 1.0);
}
#ifdef GL_ES
precision mediump float;
#endif

#define M_PI 3.1415926535897932384626433832795

uniform vec2 u_resolution;
uniform float u_time;

float circle(vec2 coord, float radius) {
    return length(coord) - radius;
}

float fill(float dist, float size){
    return smoothstep(-size, size, dist);
}

float stroke(float dist, float size, float thikness) {
    float a = smoothstep(-size, +size, dist + thikness);
    float b = smoothstep(-size, +size, dist - thikness);
    return a - b;
}

float merge(float d1, float d2) {
    return min(d1, d2);
}

float mergeExclude(float d1, float d2){
	return min(max(-d1, d2), max(-d2, d1));
}

float intersect(float d1, float d2){
	return max(d1, d2);
}

float subtract(float d1, float d2){
	return max(-d1, d2);
}

float dot2(vec2 v) {
    return length(v) * length(v);
}

float sdBezier(in vec2 pos, in vec2 A, in vec2 B, in vec2 C) {    
    vec2 a = B - A;
    vec2 b = A - 2.0*B + C;
    vec2 c = a * 2.0;
    vec2 d = A - pos;
    float kk = 1.0/dot(b,b);
    float kx = kk * dot(a,b);
    float ky = kk * (2.0*dot(a,a)+dot(d,b)) / 3.0;
    float kz = kk * dot(d,a);      
    float res = 0.0;
    float p = ky - kx*kx;
    float p3 = p*p*p;
    float q = kx*(2.0*kx*kx-3.0*ky) + kz;
    float h = q*q + 4.0*p3;
    if( h >= 0.0) 
    { 
        h = sqrt(h);
        vec2 x = (vec2(h,-h)-q)/2.0;
        vec2 uv = sign(x)*pow(abs(x), vec2(1.0/3.0));
        float t = clamp( uv.x+uv.y-kx, 0.0, 1.0 );
        res = dot2(d + (c + b*t)*t);
    }
    else
    {
        float z = sqrt(-p);
        float v = acos( q/(p*z*2.0) ) / 3.0;
        float m = cos(v);
        float n = sin(v)*1.732050808;
        vec3  t = clamp(vec3(m+m,-n-m,n-m)*z-kx,0.0,1.0);
        res = min( dot2(d+(c+b*t.x)*t.x),
                   dot2(d+(c+b*t.y)*t.y) );
        // the third root cannot be the closest
        // res = min(res,dot2(d+(c+b*t.z)*t.z));
    }
    return sqrt( res );
}

void main() {
    vec2 coord = 2.0 * gl_FragCoord.xy / u_resolution.xy - 1.0;
    coord.x *= u_resolution.x / u_resolution.y;

    vec4 colorA = vec4(0.7333, 0.3294, 0.3294, 1.0);
    vec4 colorB = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 colorC = vec4(0.3098, 0.5961, 0.6471, 1.0);

    float circleA = circle(coord + vec2(cos(0.8 * (u_time + M_PI)), cos(.8 * (u_time + M_PI))), 0.5);
    float circleB = circle(coord + vec2(cos(0.5 * u_time), cos(0.5 * u_time)), 0.5);
    float circleC = circle(coord + vec2(sin(0.4 * u_time + M_PI), -sin(0.4 * u_time + M_PI)), 0.5);
    float circleD = circle(coord + vec2(sin(0.6 * u_time), -sin(0.6 * u_time)), 0.5);
     
    float resultA = mergeExclude(circleA, circleB);
    float resultB = mergeExclude(circleC, circleD);
    float result = mergeExclude(resultA, resultB);
    //result = mergeExclude(result, bezier);
    
    float percentage = ((sin(u_time) + 1.) / 2.) * 0.1 + 0.02;
    result = stroke(result, percentage, 0.07);
    
    vec4 color = mix(colorC, colorA, result);
    float bezier = sdBezier(coord, vec2(sin(u_time), 0.), vec2(-((cos(u_time) + 1.) / 2.), 0.2), vec2(0.6, -cos(u_time)));

    float bezierResult = stroke(bezier, 0.03, 0.04);
    color = mix(color, colorB, -bezier);

    gl_FragColor=color;
    
}
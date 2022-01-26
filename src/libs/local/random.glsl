vec3 mod289(vec3 x) { 
    return x - floor(x * (1.0 / 289.0)) * 289.0; 
}

vec2 mod289(vec2 x) { 
    return x - floor(x * (1.0 / 289.0)) * 289.0; 
}

vec3 permute(vec3 x) { 
    return mod289(((x * 34.0) + 1.0) * x); 
}

float random(vec2 coord) {
    return fract(sin(dot(coord,
                         vec2(12.9898,78.233)))
                * 43758.5453123);
}

vec2 random2D(vec2 coord){
    coord = vec2(dot(coord, vec2(127.1, 311.7)),
              dot(coord, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(coord) * 43758.5453123);
}

// Cubic Hermine Curve (Custom Cubic Curve) for interplation. Same as smoothstep().
vec2 cubicHermineCurve(vec2 x) {
    return x * x * (3.0 - 2.0 * x);
}

// Cubic Hermine Curve (Custom Cubic Curve) for interplation. Same as smoothstep().
float cubicHermineCurve(float x) {
    return x * x * (3.0 - 2.0 * x);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float vnoise(vec2 coord) {
    vec2 i = floor(coord);
    vec2 f = fract(coord);
    vec2 u = cubicHermineCurve(f);

    return mix(mix(random(i + vec2(0.0,0.0)),
                    random(i + vec2(1.0,0.0)), u.x),
                mix(random(i + vec2(0.0,1.0)),
                     random(i + vec2(1.0,1.0)), u.x), u.y);
}

// Gradient Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/XdXGW8
float gnoise(vec2 coord) {
    vec2 i = floor(coord);
    vec2 f = fract(coord);
    vec2 u = cubicHermineCurve(f);

    return mix(mix(dot(random2D(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)),
                     dot(random2D(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x),
                mix(dot(random2D(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)),
                     dot(random2D(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x), u.y);
}

// Simplex Noise by
float snoise(vec2 v) {
    const vec4 C = vec4(0.211324865405187, // (3.0-sqrt(3.0))/6.0
                        0.366025403784439, // 0.5*(sqrt(3.0)-1.0)
                        -0.577350269189626, // -1.0 + 2.0 * C.x
                        0.024390243902439); // 1.0 / 41.0

    vec2 i  = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;
    i = mod289(i); // Avoid truncation effects in permutation
    vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
        + i.x + vec3(0.0, i1.x, 1.0 ));

    vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
    m = m * m ;
    m = m * m ;
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}


vec3 random3D(vec3 c) {
    float j = 4096.0 * sin(dot(c,vec3(17.0, 59.4, 15.0)));
    vec3 r;

    r.z = fract(512.0 * j);
    j *= .125;
    r.x = fract(512.0 * j);
    j *= .125;
    r.y = fract(512.0 * j);
    
    return r - 0.5;
}

const float F3 =  0.3333333;
const float G3 =  0.1666667;

float snoise(vec3 p) {
    vec3 s = floor(p + dot(p, vec3(F3)));
    vec3 x = p - s + dot(s, vec3(G3));

    vec3 e = step(vec3(0.0), x - x.yzx);
    vec3 i1 = e*(1.0 - e.zxy);
    vec3 i2 = 1.0 - e.zxy*(1.0 - e);

    vec3 x1 = x - i1 + G3;
    vec3 x2 = x - i2 + 2.0*G3;
    vec3 x3 = x - 1.0 + 3.0*G3;

    vec4 w, d;

    w.x = dot(x, x);
    w.y = dot(x1, x1);
    w.z = dot(x2, x2);
    w.w = dot(x3, x3);

    w = max(0.6 - w, 0.0);

    d.x = dot(random3D(s), x);
    d.y = dot(random3D(s + i1), x1);
    d.z = dot(random3D(s + i2), x2);
    d.w = dot(random3D(s + 1.0), x3);

    w *= w;
    w *= w;
    d *= w;

    return dot(d, vec4(52.0));
}


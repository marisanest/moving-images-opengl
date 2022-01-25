#include "./math.glsl"

bool isWithinBox(vec2 coord, vec2 box) {
    return coord.x >= -box.x && coord.x <= box.x && coord.y >= -box.y && coord.y <= box.y;
}

bool isWithinCircle(vec2 coord, float radius) {
    return length(coord) <= radius;
}

float distanceCircleBorderToCircleCenter(vec2 coord, float radius, float DistanceOutsideCircleBorder) {
    if (isWithinCircle(coord, radius)) {
        return radius - length(coord);
    } else {
        return DistanceOutsideCircleBorder;
    }
}

float distanceCircleBorderToCircleCenter(vec2 coord, float radius) {
    return radius - length(coord);
}

float distanceCircleBorderToOutside(vec2 coord, float radius, float distanceWithinCircleBorder) {
    if (isWithinCircle(coord, radius)) {
        return distanceWithinCircleBorder;
    } else {
        return length(coord) - radius;
    }
}

float distanceCircleBorderToOutside(vec2 coord, float radius) {
    return length(coord) - radius;
}

float distanceCircleBorderToBothSides(vec2 coord, float radius) {
    if (isWithinCircle(coord, radius)) {
        return distanceCircleBorderToCircleCenter(coord, radius);
    } else {
        return distanceCircleBorderToOutside(coord, radius);
    }
}

float circle(vec2 coord, float radius) {
    return distanceCircleBorderToOutside(coord, radius);
}

float box(vec2 p, vec2 b){
    vec2 d = abs(p) - b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
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

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}
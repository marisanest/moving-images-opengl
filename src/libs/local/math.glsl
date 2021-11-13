#define M_PI 3.1415926535897932384626433832795

float adjustY(float y, float minY, float maxY) {
    float ratio = (maxY - minY) / 2.0;
    y *= ratio;
    y += (minY + (1. * ratio));
    return y;
}

float sin(float x, float frequency, float minY, float maxY) {
   return adjustY(sin(x * frequency), minY, maxY);
}

float cos(float x, float frequency, float minY, float maxY) {
    return adjustY(cos(x * frequency), minY, maxY);
}

float dot2(vec2 x) {
    return length(x) * length(x);
}
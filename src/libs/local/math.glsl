#define PI 3.1415926535897932384626433832795

float applyMinMax(float value, float minValue, float maxValue) {
    float ratio = (maxValue - minValue) / 2.0;
    value *= ratio;
    value += (minValue + (1. * ratio));
    return value;
}

float applyFrequency(float value, float frequency) {
    return value * frequency;
}

float adjustedSin(float value, float frequency, float minValue, float maxValue) {
    value = applyFrequency(value, frequency);
    value = sin(value);
    value = applyMinMax(value, minValue, maxValue);
    return value;
}

float adjustedCos(float value, float frequency, float minValue, float maxValue) {
    value = applyFrequency(value, frequency);
    value = cos(value);
    value = applyMinMax(value, minValue, maxValue);
    return value;
}

float dot2(vec2 x) {
    return length(x) * length(x);
}
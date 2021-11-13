float fill(float distribution){
    return smoothstep(-0.1, 0.1, distribution);
}

float fill(float distribution, float size){
    return smoothstep(-size, size, distribution);
}

float plot(vec2 coord, float x) {
    return smoothstep(x - 0.2, x, coord.y) - smoothstep(x, x + 0.02, coord.y);
}

float stroke(float distribution, float outerRange, float innerRange, float thikness) {
    float inner = smoothstep(-innerRange, innerRange, distribution + thikness / 2.);
    float outer = smoothstep(-outerRange, outerRange, distribution - thikness / 2.);
    return inner - outer;
}

float stroke(float distribution, float range, float thikness) {
    return stroke(distribution, range, range, thikness);
}
bool isWithinBox(vec2 coord, vec2 box) {
    return coord.x >= -box.x && coord.x <= box.x && coord.y >= -box.y && coord.y <= box.y; // test also with ^^
}

bool isWithinCircle(vec2 coord, float radius) {
    return length(coord) <= radius;
}

float distanceCircleCenterToCircleBorder(vec2 coord, float radius) {
    return radius - length(coord);
}

float distanceCircleBordertoOutside(vec2 coord, float radius) {
    return length(coord) - radius;
}
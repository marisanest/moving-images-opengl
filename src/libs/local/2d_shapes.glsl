bool is_within_box(vec2 coord, vec2 box) {
    return coord.x >= -box.x && coord.x <= box.x && coord.y >= -box.y && coord.y <= box.y;
}

bool is_within_circle(vec2 coord, float radius) {
    return length(coord) <= radius;
}

float distance_circle_border_to_circle_center(vec2 coord, float radius, float distance_outside_circle_border) {
    if (length(coord) <= radius) {
        return radius - length(coord);
    } else {
        return distance_outside_circle_border;
    }
}


float distance_circle_border_to_circle_center(vec2 coord, float radius) {
    if (length(coord) <= radius) {
        return radius - length(coord);
    } else {
        return -1.;
    }
}

float distance_circle_border_to_outside(vec2 coord, float radius, float distance_within_circle_border) {
    if (length(coord) >= radius) {
        return length(coord) - radius;
    } else {
        return distance_within_circle_border;
    }
}

float distance_circle_border_to_outside(vec2 coord, float radius) {
    if (length(coord) >= radius) {
        return length(coord) - radius;
    } else {
        return -1.;
    }
}

float distance_circle_border_to_both_sides(vec2 coord, float radius) {
    if (length(coord) <= radius) {
        return distance_circle_border_to_circle_center(coord, radius);
    } else {
        return distance_circle_border_to_outside(coord, radius);
    }
}
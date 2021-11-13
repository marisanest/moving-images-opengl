#ifdef GL_ES
precision mediump float;
#endif

#define M_PI 3.1415926535897932384626433832795

uniform vec2 u_resolution;
uniform float u_time;

#include "../libs/edap/2dshapes.glsl"
#include "../libs/edap/boolean-ops.glsl"
#include "../libs/local/2dshapes.glsl"

float adjust_y(float y, float min_y, float max_y) {
    float ratio = (max_y - min_y) / 2.0;
    y *= ratio;
    y += (min_y + (1. * ratio));
    return y;
}

float stroke(float distribution, float outer_range, float inner_range, float thikness) {
    float inner = smoothstep(-inner_range, inner_range, distribution + thikness / 2.);
    float outer = smoothstep(-outer_range, outer_range, distribution - thikness / 2.);
    return inner - outer;
}

float sin(float x, float frequency, float min_y, float max_y) {
   return adjust_y(sin(x * frequency), min_y, max_y);
}

float cos(float x, float frequency, float min_y, float max_y) {
    return adjust_y(cos(x * frequency), min_y, max_y);
}

void main() {
    float box_radius = 0.15;
    float percentage;
    float radius;
    float max_radius = 0.03;
    float smooth_step_size = 0.02;
    float thikness = 0.05;
    vec2 ratio = vec2(u_resolution.x / u_resolution.y, u_resolution.y / u_resolution.x);

    // why do we need to substract here?
    float x = gl_FragCoord.x / u_resolution.x - (ratio.y * box_radius);
    x *= ratio.x;
    float y = gl_FragCoord.y / u_resolution.y - box_radius;

    vec2 n_boxes = vec2(floor(ratio.x / (box_radius * 2.)), floor(1.0 / (box_radius * 2.)));
    vec2 margin = vec2((ratio.x - n_boxes.x * 2. * box_radius) / 2., (1.0 - n_boxes.y * 2. * box_radius) / 2.);

    vec4 colorA = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 colorB = vec4(0.549, 0.0, 1.0, 1.0);
    vec4 colorC;
    vec4 colorD = vec4(0.2353, 1.0, 0.0, 1.0);
    
    float current_circle;
    float merged_circles;
    float circle_strokes;

    for (int x_i = 0; x_i >= 0; ++x_i) {
        for (int y_i = 0; y_i >= 0; ++y_i) {
            percentage = sin((u_time + M_PI * float(x_i) + float(y_i))) + 1.0;
            radius = percentage * max_radius;
            current_circle = circle(vec2(x - margin.x - float(x_i) * 2. * box_radius, y - margin.y - float(y_i) * 2. * box_radius), radius);

            if (x_i == 0 && y_i == 0) {
                merged_circles = current_circle;
            } else {
                merged_circles = merge(merged_circles, current_circle);
            }

            if (y_i + 1 >= int(n_boxes.y)) {
                break;
            }
        }
        if (x_i + 1 >= int(n_boxes.x)) {
            break;
        }
    }

    circle_strokes = stroke(merged_circles, .002, 0.05, thikness);
    colorC = mix(colorA, colorB, circle_strokes);

    for (int x_i = 0; x_i >= 0; ++x_i) {
        for (int y_i = 0; y_i >= 0; ++y_i) {
            current_circle = circle(
                vec2(x - margin.x - float(x_i) * 2. * box_radius, y - margin.y - float(y_i) * 2. * box_radius), 
                sin(u_time, 1., 0.0, .1)
            );

            if (x_i == 0 && y_i == 0) {
                merged_circles = current_circle;
            } else {
                merged_circles = merge(merged_circles, current_circle);
            }

            if (y_i + 1 >= int(n_boxes.y)) {
                break;
            }
        }
        if (x_i + 1 >= int(n_boxes.x)) {
            break;
        }
    }

    circle_strokes = stroke(
        merged_circles, 
        sin(u_time, 1., 0.005, 0.07),  
        cos(u_time, 1., 0.005, 0.07), 
        0.02
    );

    colorC = mix(colorC, colorD, circle_strokes);

    gl_FragColor=colorC;
}
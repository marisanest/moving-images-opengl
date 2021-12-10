#include "./2dshapes.glsl"
#include "./boolean-ops.glsl"


float calculateRadiusDefault() {
    return 0.1;
}

float calculateRadiusV1(int xI, int yI) {
    return MAX_RADIUS * adjustedCos(u_time + PI * float(xI) + float(yI), 1.0, 0.0, 2.0);
}

float calculateRadiusV2() {
    return adjustedCos(u_time, 1., 0.0, .1);
}

float calculateRadiusV3(int xI, int yI) {
    return MAX_RADIUS * adjustedCos(u_time + PI * float(xI) + float(yI), 1.0, 0.0, 2.0);
}

float calculateRadius(int radiusV, int xI, int yI) {
    if (radiusV == 1) {
        return calculateRadiusV1(xI, yI);
    } else if (radiusV == 2){
        return calculateRadiusV2();
    } else if (radiusV == 3){
        return calculateRadiusV3(xI, yI);
    } else {
        return calculateRadiusDefault();
    }
}

vec2 calculateCoordV1(vec2 coord, int xI, int yI, vec2 margin) {
    return vec2(coord.x - margin.x - float(xI) * 2. * BOX_RADIUS, coord.y - margin.y - float(yI) * 2. * BOX_RADIUS);
}

vec2 calculateCoordDefault(vec2 coord) {
    return coord;
}

vec2 calculateCoord(int coordV, vec2 coord, int xI, int yI, vec2 margin) {
    if (coordV == 1) {
        return calculateCoordV1(coord, xI, yI, margin);
    } else {
        return calculateCoordDefault(coord);
    }
}

float drawCircles(vec2 coord, vec2 nCircles, vec2 margin, int radiusV, int coordV) {
    float currentCircle;
    float mergedCircles;
    float percentage;
    float radius;

    for (int xI = 0; xI >= -1; ++xI) {
        for (int yI = 0; yI >= -1; ++yI) {
            currentCircle = circle(
                calculateCoord(coordV, coord, xI, yI, margin), 
                calculateRadius(radiusV, xI, yI)
            );

            if (xI == 0 && yI == 0) {
                mergedCircles = currentCircle;
            } else {
                mergedCircles = merge(mergedCircles, currentCircle);
            }
            if (yI + 1 >= int(nCircles.y)) {
                break;
            }
        }
        if (xI + 1 >= int(nCircles.x)) {
            break;
        }
    }

    return mergedCircles;
}
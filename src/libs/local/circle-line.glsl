vec4 movingCircle(vec2 st, vec4 color, vec4 colorResult) {
    float circleResult = circle(st, 0.2);
    float strokeResult = stroke(circleResult, .002, 0.05, 0.05);
    colorResult = mix(color, colorResult, 1. - strokeResult);

    return colorResult;
}

vec2 updateCircleLineCoord(vec2 coord, float translationValue) {
    vec2 updatedCoord = scaleCoord(coord, vec2(1., sin(u_time, 1., 0., 1.)));
    updatedCoord = translateCoord(updatedCoord, vec2(translationValue, 0));
    return updatedCoord;
}

vec4 circleLine(vec2 st, vec4 colorResult, float rotateFactor, float maxBaseScaleFactor) {
    vec4 colorA = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 colorB = vec4(0.5176, 0.0, 1.0, 1.0);

    float circleResult;
    float strokeResult;

    vec2 circleBaseSt = st;
    vec2 circleLeftSt = st;
    vec2 circleRightBSt = st;

    float translationValue = sin(u_time, 1., 0.1, .5);

    circleBaseSt = rotateCoord(circleBaseSt, sin(u_time + rotateFactor * M_PI));    
    circleBaseSt = scaleCoord(circleBaseSt, vec2(1., sin(u_time, 1.0, 0., maxBaseScaleFactor))); // vec2(1., .0), vec2(1., .5)
    circleLeftSt = circleBaseSt;
    circleRightBSt = circleBaseSt;

    colorResult = movingCircle(circleBaseSt, colorA, colorResult);

    circleLeftSt = updateCircleLineCoord(circleLeftSt, translationValue);
    colorResult = movingCircle(circleLeftSt, colorB, colorResult);

    circleRightBSt = updateCircleLineCoord(circleRightBSt, -translationValue);
    colorResult = movingCircle(circleRightBSt, colorB, colorResult);

    circleLeftSt = updateCircleLineCoord(circleLeftSt, translationValue);
    colorResult = movingCircle(circleLeftSt, colorB, colorResult);
    
    circleRightBSt = updateCircleLineCoord(circleRightBSt, -translationValue);
    colorResult = movingCircle(circleRightBSt, colorB, colorResult);

    return colorResult;
}

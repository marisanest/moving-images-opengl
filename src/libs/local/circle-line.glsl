vec4 movingCircle(vec2 st, vec4 color, vec4 colorResult) {
    float circleResult = circle(st, 0.2);
    float strokeResult = stroke(circleResult, .002, 0.05, 0.05);
    colorResult = mix(color, colorResult, 1. - strokeResult);

    return colorResult;
}

vec2 updateCircleLineCoord(vec2 coord, float translationValue) {
    vec2 updatedCoord = scaleCoord(coord, vec2(1., adjustedCos(u_time, 1., 0., 1.)));
    updatedCoord = translateCoord(updatedCoord, vec2(translationValue, 0));
    return updatedCoord;
}

vec4 circleLine(vec2 st, vec4 innerCircleColor, vec4 outerCircleColor, vec4 currentColor, float rotateFactor, float maxBaseScaleFactor) {
    float circleResult;
    float strokeResult;

    vec2 circleBaseSt = st;
    vec2 circleLeftSt = st;
    vec2 circleRightBSt = st;

    float translationValue = adjustedCos(u_time, 1., 0.1, .5);

    circleBaseSt = rotateCoord(circleBaseSt, sin(u_time + rotateFactor * M_PI));    
    circleBaseSt = scaleCoord(circleBaseSt, vec2(1., adjustedCos(u_time, 1.0, 0., maxBaseScaleFactor))); // vec2(1., .0), vec2(1., .5)
    circleLeftSt = circleBaseSt;
    circleRightBSt = circleBaseSt;

    currentColor = movingCircle(circleBaseSt, innerCircleColor, currentColor);

    circleLeftSt = updateCircleLineCoord(circleLeftSt, translationValue);
    currentColor = movingCircle(circleLeftSt, outerCircleColor, currentColor);

    circleRightBSt = updateCircleLineCoord(circleRightBSt, -translationValue);
    currentColor = movingCircle(circleRightBSt, outerCircleColor, currentColor);

    circleLeftSt = updateCircleLineCoord(circleLeftSt, translationValue);
    currentColor = movingCircle(circleLeftSt, outerCircleColor, currentColor);
    
    circleRightBSt = updateCircleLineCoord(circleRightBSt, -translationValue);
    currentColor = movingCircle(circleRightBSt, outerCircleColor, currentColor);

    return currentColor;
}

vec2 updateSmileyEyeCoord(vec2 coord, float translateValueX, float cosMaxValue) {
    vec2 updatedCoord = translateCoord(
        coord, 
        vec2(translateValueX, adjustedCos(u_time, 1.0, -.4, cosMaxValue))
    );
    updatedCoord = scaleCoord(
        updatedCoord, 
        vec2(0.8, 0.8)
    );

    return updatedCoord;
}

float smileyEye(vec2 coord) {
    return sdBezier(
        coord, 
        vec2(.0, .0), 
        vec2(.0, .0), 
        vec2(.0, adjustedSin(u_time, 1.0, 0.0, 0.1))
    );
}

vec2 updateSmileyMouthCoord(vec2 coord) {
    return translateCoord(
        coord, 
        vec2(0.0, adjustedSin(u_time, 1.0, 0.2, 0.5))
    );
}

float smileyMouth(vec2 coord) {
    return sdBezier(
        coord, 
        vec2(-.4, .0), 
        vec2(.0, adjustedCos(u_time, 1.0, -0.5, 0.3)), 
        vec2(0.4, .0)
    );
}

vec4 smiley(vec2 st, vec4 smileyColor, vec4 currentColor, bool asWindow) {
    float strokeResult;
    
    float bezierA;
    float bezierB;
    float bezierC;
    float bezierResult;
    
    vec2 bezierASt = st;
    vec2 bezierBSt = st;
    vec2 bezierCSt = st;

    bezierASt = updateSmileyEyeCoord(bezierASt, -0.2, -0.20);
    bezierA = smileyEye(bezierASt);

    bezierBSt = updateSmileyEyeCoord(bezierBSt, 0.2, -0.20);
    bezierB = smileyEye(bezierBSt);
    
    bezierResult = merge(bezierA, bezierB);

    bezierCSt = updateSmileyMouthCoord(bezierCSt);
    bezierC = smileyMouth(bezierCSt);
    
    bezierResult = merge(bezierResult, bezierC);

    strokeResult = stroke(bezierResult, .003, 0.2, 0.2);

    if (asWindow) {
        currentColor = mix(smileyColor, currentColor, strokeResult);
    } else {
        currentColor = mix(smileyColor, currentColor, 1. - strokeResult);
    }

    return currentColor;
}
//
//  Scanlines.metal
//  SetctlModules
//
//  Created by Samuel Meads on 10/7/26.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 scanlines(float2 position, half4 color) {
    float line = sin(position.y * 1.5) * 0.5 + 0.5;
    half darken = half(mix(0.7, 1.0, line));
    return half4(color.rgb * darken, color.a);
}

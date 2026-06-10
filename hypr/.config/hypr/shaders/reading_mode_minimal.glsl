#version 320 es
/*
   E-ink display shader — clean text
   Tone curve from Fujifilm Acros, colors from e-ink shader
   by @snes19xx / adapted
*/
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

float acrosCurve(float t) {
    t = max(t - 0.04, 0.0) / 0.96;
    float toe      = smoothstep(0.0, 0.35, t);
    float mid      = smoothstep(0.2, 0.8,  t);
    float shoulder = smoothstep(0.65, 1.0, t);
    return mix(toe * 0.6, mix(mid * 0.85, t, shoulder * 0.4), 0.5);
}

float vignette(vec2 uv) {
    vec2 center = uv - 0.5;
    return 1.0 - smoothstep(0.4, 1.2, length(center)) * 0.15;
}

void main() {
    vec4 pixColor = texture(tex, v_texcoord);

    // Acros luma weights — stronger green channel, better for text rendering
    float luma = dot(pixColor.rgb, vec3(0.18, 0.74, 0.08));

    // Acros tone curve — proper toe keeps blacks deep, shoulder protects whites
    luma = acrosCurve(luma);

    luma *= vignette(v_texcoord);
    luma = clamp(luma, 0.0, 1.0);

    vec3 paperColor = vec3(0.94, 0.92, 0.86);
    vec3 inkColor   = vec3(0.10, 0.10, 0.12);

    fragColor = vec4(mix(inkColor, paperColor, luma), pixColor.a);
}

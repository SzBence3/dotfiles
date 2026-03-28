#version 300 es
precision mediump float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

// Parameters to tweak the feel
const float contrast = 1.2;
const float brightness = 0.05;
const float grain_strength = 0.03;
const vec3 paper_tint = vec3(0.95, 0.94, 0.88); // Slight off-white/sepia

// Pseudo-random function for grain
float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec4 pix = texture2D(tex, v_texcoord);

    // 1. Convert to Grayscale (Luminance weights)
    float gray = dot(pix.rgb, vec3(0.299, 0.587, 0.114));

    // 2. Apply Contrast and Brightness
    gray = (gray - 0.5) * contrast + 0.5 + brightness;

    // 3. Simple Ordered Dithering (Simulates E-Ink pixel density)
    // This creates a subtle checkerboard pattern in midtones
    float dither = noise(v_texcoord * 1000.0);
    if (gray < dither * 0.1) gray -= 0.05;
    if (gray > 1.0 - (dither * 0.1)) gray += 0.05;

    // 4. Add Paper Grain
    float n = (noise(v_texcoord * 500.0) - 0.5) * grain_strength;
    gray += n;

    // 5. Clamp values and apply Paper Tint
    gray = clamp(gray, 0.0, 1.0);
    vec3 finalColor = gray * paper_tint;

    fragColor = vec4(finalColor, pix.a);
}

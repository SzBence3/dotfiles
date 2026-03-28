// from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1614863627

#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;



void main() {
    vec4 pixColor = texture(tex, v_texcoord);

    float light = 0.299 * pixColor.r + 0.587 * pixColor.g + 0.114 * pixColor.b;

    fragColor = vec4(
        light, // red channel
        1.0 - 2.0*abs(0.5 - light),   // green channel
        1.0 - light, // blue channel
        1.0    // alpha channel
    );
}

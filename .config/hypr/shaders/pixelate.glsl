// from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1614863627

#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;



void main() {
    vec2 newTexCoord = floor(v_texcoord * vec2(100.0, 100.0)) / vec2(100.0, 100.0);

    vec4 pixColor = texture(tex, newTexCoord);

    // Convert the pixel color to grayscale using the luminosity method
    fragColor = pixColor;
}

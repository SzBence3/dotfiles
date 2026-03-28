// from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1614863627

#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;



void main() {
vec2 newTexcoord = v_texcoord + vec2(sin(v_texcoord.y * 30.0) * 0.01, sin(v_texcoord.x * 30.0) * 0.01);

    vec4 pixColor = texture(tex, newTexcoord);

    fragColor = pixColor;
}

// from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1614863627

#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;



void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    float t[9];
    t[0] = -0.125; t[1] = -0.125; t[2] = -0.125;
    t[3] = -0.125; t[4] = 1.0;   t[5] = -0.125;
    t[6] = -0.125; t[7] = -0.125; t[8] = -0.125;

    vec2 delta = vec2(1.0) / vec2(textureSize(tex, 0));
    delta *= 4.0;
    
    vec4 summedColor = vec4(0.0);

    summedColor += texture(tex, v_texcoord + vec2(-delta.x, -delta.y)) * t[0];
    summedColor += texture(tex, v_texcoord + vec2(0.0, -delta.y)) * t[1];
    summedColor += texture(tex, v_texcoord + vec2( delta.x, -delta.y)) * t[2];
    summedColor += texture(tex, v_texcoord + vec2(-delta.x, 0.0)) * t[3];
    summedColor += texture(tex, v_texcoord) * t[4];
    summedColor += texture(tex, v_texcoord + vec2( delta.x, 0.0)) * t[5];
    summedColor += texture(tex, v_texcoord + vec2(-delta.x, delta.y)) * t[6];
    summedColor += texture(tex, v_texcoord + vec2(0.0, delta.y)) * t[7];
    summedColor += texture(tex, v_texcoord + vec2( delta.x, delta.y)) * t[8];

    fragColor = vec4(summedColor.rgb, pixColor.a);
}

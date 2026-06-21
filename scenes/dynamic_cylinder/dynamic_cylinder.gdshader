shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
    vec4 c = textureLod(screen_texture, SCREEN_UV, 0.0);

    if (c.a > 0.0001) {
        c.rgb /= c.a;
    }

    COLOR *= c;
	if (COLOR == vec4(0,0,0,1)){
		COLOR = vec4(0,0,0,0);
	}
}

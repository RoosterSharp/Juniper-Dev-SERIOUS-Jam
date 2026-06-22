shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform vec4 outline_color : source_color;

vec4 get_color(vec2 screen_uv){
	vec4 c = textureLod(screen_texture, screen_uv, 0.0);
	
	if (c.a > 0.0001) {
	c.rgb /= c.a;
	}
	
	if (c == vec4(0,0,0,1)){
		c = vec4(0,0,0,0);
	}
	
	return c;
}

void fragment() {
	COLOR = get_color(SCREEN_UV);
	if (COLOR == vec4(0,0,0,0)){
		if (
			get_color(SCREEN_UV+vec2(1,0)*SCREEN_PIXEL_SIZE) != vec4(0,0,0,0) ||
			get_color(SCREEN_UV+vec2(-1,0)*SCREEN_PIXEL_SIZE) != vec4(0,0,0,0) ||
			get_color(SCREEN_UV+vec2(0,1)*SCREEN_PIXEL_SIZE) != vec4(0,0,0,0) ||
			get_color(SCREEN_UV+vec2(0,-1)*SCREEN_PIXEL_SIZE) != vec4(0,0,0,0)
		){
			COLOR = outline_color;
		}
	}
}

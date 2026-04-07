shader_type canvas_item;

instance uniform bool is_enabled = false;

uniform vec4 outline_color : source_color = vec4(1.0);
uniform float outline_size = 2.0;
uniform float alpha_threshold : hint_range(0.0, 1.0) = 0.99;

void fragment() {
	if (is_enabled) {
		vec4 final_color = texture(TEXTURE, UV);
		
		float outline = 0.0;
		outline += texture(TEXTURE, UV + vec2(outline_size, 0.0) * TEXTURE_PIXEL_SIZE).a;
		outline += texture(TEXTURE, UV + vec2(-outline_size, 0.0) * TEXTURE_PIXEL_SIZE).a;
		outline += texture(TEXTURE, UV + vec2(0.0, outline_size) * TEXTURE_PIXEL_SIZE).a;
		outline += texture(TEXTURE, UV + vec2(0.0, -outline_size) * TEXTURE_PIXEL_SIZE).a;
		
		if (final_color.a < alpha_threshold && outline > 0.0) {
			final_color = outline_color;
		}
		
		COLOR = final_color;
	}
}

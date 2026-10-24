shader_type canvas_item;

uniform vec4 keyColor : source_color = vec4(0,1,0,1);
uniform sampler2D destTexture : source_color, filter_nearest;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	
	if (tex_color == keyColor) {
		// Fetch the matching screen pixel from Scene A behind the overlay
		vec4 screen_color = texture(destTexture, SCREEN_UV);
		COLOR = screen_color;
	} else {
		// Otherwise, keep your custom animation's pixels (solid parts and transparent parts)
		COLOR = tex_color;
	}
}
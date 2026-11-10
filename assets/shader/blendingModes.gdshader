shader_type canvas_item;
uniform int blend_mode : hint_enum(
	"multiply",
	"screen",
	"darken",
	"lighten",
	"difference",
	"exclusion",
	"overlay",
	"hard_light",
	"soft_light",
	"color_dodge",
	"linear_dodge",
	"color_burn",
	"linear_burn"
) = 0;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

vec3 multiply(vec3 base, vec3 blend){
	return base * blend;
}
vec3 screen(vec3 base, vec3 blend){
	return 1.0 - (1.0 - base) * (1.0 - blend);
}
vec3 darken(vec3 base, vec3 blend){
	return min(base, blend);
}
vec3 lighten(vec3 base, vec3 blend){
	return max(base, blend);
}
vec3 difference(vec3 base, vec3 blend){
	return abs(base - blend);
}
vec3 exclusion(vec3 base, vec3 blend){
	return base + blend - 2.0 * base * blend;
}
vec3 overlay(vec3 base, vec3 blend){
	vec3 limit = step(0.5, base);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}
vec3 hard_light(vec3 base, vec3 blend){
	vec3 limit = step(0.5, blend);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}
vec3 soft_light(vec3 base, vec3 blend){
	vec3 limit = step(0.5, blend);
	return mix(2.0 * base * blend + base * base * (1.0 - 2.0 * blend), sqrt(base) * (2.0 * blend - 1.0) + (2.0 * base) * (1.0 - blend), limit);
}
float color_dodge_channel(float base, float blend){
	if (base == 0.0) return 0.0;
	if (blend == 1.0) return 1.0;
	return min(1.0, base / (1.0 - blend));
}

vec3 color_dodge(vec3 base, vec3 blend){
	return vec3(color_dodge_channel(base.r, blend.r),
				color_dodge_channel(base.g, blend.g),
				color_dodge_channel(base.b, blend.b));
}
vec3 linear_dodge(vec3 base, vec3 blend){
	return base + blend;
}
float color_burn_channel(float base, float blend){
	if (base == 1.0) return 1.0;
	if (blend == 0.0) return 0.0;
	return 1.0 - min(1.0, (1.0 - base) / blend);
}

vec3 color_burn(vec3 base, vec3 blend){
	return vec3(color_burn_channel(base.r, blend.r),
				color_burn_channel(base.g, blend.g),
				color_burn_channel(base.b, blend.b));
}
vec3 linear_burn (vec3 base, vec3 blend)
{
	return base + blend - 1.0;
}

vec3 blend_by_mode(vec3 base, vec3 blend) {
	switch (blend_mode) {
		case 0:
			return multiply(base, blend);
		case 1:
			return screen(base, blend);
		case 2:
			return darken(base, blend);
		case 3:
			return lighten(base, blend);
		case 4:
			return difference(base, blend);
		case 5:
			return exclusion(base, blend);
		case 6:
			return overlay(base, blend);
		case 7:
			return hard_light(base, blend);
		case 8:
			return soft_light(base, blend);
		case 9:
			return color_dodge(base, blend);
		case 10:
			return linear_dodge(base, blend);
		case 11:
			return color_burn(base, blend);
		case 12:
			return linear_burn(base, blend);
		default:
			return base;
	}
}

void fragment() {
	vec4 screenColor = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec4 base = texture(TEXTURE, UV);
	vec4 blend = screenColor;
	COLOR = vec4(blend_by_mode(base.rgb, blend.rgb), base.a);
}
//https://www.youtube.com/watch?v=Pu2muzzvS4M
// never really explained hbut it works...

shader_type canvas_item;

uniform float brightness : hint_range(-1,1,.01) = 0.0;
uniform float contrast : hint_range(0.0, 5.0,.01) = 1.0;

mat4 brightness_m(float b){
	return mat4(
		vec4(1,0,0,0),
		vec4(0,1,0,0),
		vec4(0,0,1,0),
		vec4(b,b,b,1)
	);
}

mat4 contrast_m(float c){
	float t = (1.0-c)/2.0;
	return mat4(
		vec4(c,0,0,0),
		vec4(0,c,0,0),
		vec4(0,0,c,0),
		vec4(t,t,t,1)
	);
}
void fragment() {
    vec4 color = texture(TEXTURE, UV);
    mat4 matrix = brightness_m(brightness)*contrast_m(contrast);
    
    COLOR = matrix * color;
}

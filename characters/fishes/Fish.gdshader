shader_type canvas_item;

uniform sampler2D dissolve_texture : source_color;
uniform float dissolve_value : hint_range(0,1);
uniform float burn_size: hint_range(0.0, 1.0, 0.01);
uniform vec4 burn_color: source_color;

uniform bool rainbow  = false; //Activate the rainbow or select you color
uniform bool highlight = false;
uniform vec4 line_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);//color line
uniform float line_scale : hint_range(0, 20) = 1.2;    // thickness of the line
uniform float frequency : hint_range(0.0, 2.0) = 0.5;  // frequency of the rainbow
uniform float light_offset : hint_range(0.00001, 1.0) = 0.5;   // this offsets all color channels;
uniform float alpha : hint_range(0.0, 1.0) = 1.0;

void fragment(){
	vec2 size = TEXTURE_PIXEL_SIZE * line_scale;
	if(dissolve_value == 1.0){
		float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
		outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
		outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
		outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
		outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
		outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
		outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
		outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
		outline = min(outline, 1.0);
		
		vec4 animated_line_color = vec4(light_offset + sin(2.0*3.14*frequency*TIME),
								   light_offset + sin(2.0*3.14*frequency*TIME + radians(120.0)),
								   light_offset + sin(2.0*3.14*frequency*TIME + radians(240.0)),
								   alpha);
		
		vec4 color = texture(TEXTURE, UV);
		if (rainbow == true){//if rainbow is activated
			COLOR = mix(color, animated_line_color, outline - color.a);
		}
		if (rainbow == false && highlight == true){//if rainbow not is activated and you pick a color
			COLOR = mix(color, line_color , outline - color.a);
		}
	}
	
	
    vec4 main_texture = texture(TEXTURE, UV);
    vec4 noise_texture = texture(dissolve_texture, UV);
	
	// This is needed to avoid keeping a small burn_color dot with dissolve being 0 or 1
	// is there another way to do it?
	float burn_size_step = burn_size * step(0.001, dissolve_value) * step(dissolve_value, 0.999);
	float threshold = smoothstep(noise_texture.x-burn_size_step, noise_texture.x, dissolve_value);
	float border = smoothstep(noise_texture.x, noise_texture.x + burn_size_step, dissolve_value);
	if(dissolve_value != 1.0){
		COLOR.a *= threshold;
		COLOR.rgb = mix(burn_color.rgb, main_texture.rgb, border);
	}
}
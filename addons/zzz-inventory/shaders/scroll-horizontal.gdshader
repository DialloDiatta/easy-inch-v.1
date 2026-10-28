shader_type canvas_item;


uniform float speed = .1;
uniform float angle = 45.0;

vec2 rotate(vec2 uv, float rotation_angle, float aspect_ratio) {
	// Set the aspect ratio to adjust the UV space (which is always square)
	// to the texture's ratio.

	uv.x *= aspect_ratio;

	// Rotation Functionality
    float radians_angle = radians(rotation_angle);
    float cos_angle = cos(radians_angle);
    float sin_angle = sin(radians_angle);
    mat2 rotation_matrix = mat2(vec2(cos_angle, -sin_angle), vec2(sin_angle, cos_angle));
	uv = uv * rotation_matrix;

	// Undo the changes to the aspect ratio earlier.
	uv.x /= aspect_ratio;
	return uv;
}

void vertex() {
	UV.x += TIME * .1;
	UV.y -= TIME * .4;
	//// Calculate translation direction from angle.
	//float radians_angle = radians(angle);
	//vec2 translation_direction = vec2(cos(radians_angle), -sin(radians_angle));
	//UV += translation_direction * TIME * speed;
}

void fragment() {
	vec2 uv = UV;



	// Set the center of the UV for rotation pivot.
	uv -= 0.5;
	float aspect_ratio = 1.0 / (TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y);
	uv = rotate(uv, angle, aspect_ratio);
	// Set the UV back to where it was.
	uv += 0.5;
	COLOR = texture(TEXTURE, uv);
}

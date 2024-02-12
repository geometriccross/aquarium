static func input_vector():
	var up = int(Input.is_key_pressed(KEY_W))
	var down = int(Input.is_key_pressed(KEY_S))
	var left = int(Input.is_key_pressed(KEY_A))
	var right = int(Input.is_key_pressed(KEY_D))
	
	return Vector2(-left + right, -up + down)

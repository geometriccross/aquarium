static func input_vector():
	var up = int(Input.is_key_pressed(KEY_W))
	var down = int(Input.is_key_pressed(KEY_S))
	var left = int(Input.is_key_pressed(KEY_A))
	var right = int(Input.is_key_pressed(KEY_D))
	
	return Vector2(-left + right, -up + down)

static func id(x):
	return x

static func probability_remap(data: Array):
	data.sort()
	var acc = 0
	var i = 0
	
	for x in data:
		data[i] += acc
		acc += data[i]
		i += 1

	return data.map(func(x): return min(x, 1.0))

static  func probability_remap_with_jag(data: Array):
	#100掛けるのは桁落ち防止
	data.sort()
	var acc = 0
	var i = 0
	
	for x in data:
		data[i][0] += acc
		acc += data[i][0]
		i += 1
	
	return data.map(func(x): return min(x[0], 1.0))

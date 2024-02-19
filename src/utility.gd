static func input_vector():
	var up = int(Input.is_key_pressed(KEY_W))
	var down = int(Input.is_key_pressed(KEY_S))
	var left = int(Input.is_key_pressed(KEY_A))
	var right = int(Input.is_key_pressed(KEY_D))
	
	return Vector2(-left + right, -up + down)

static func id(x):
	return x

static func map(f: Callable, array: Array):
	var result = []
	for x in array:
		result.append(f.call(x))
	
	return result

static func probability_remap(data: Array):
	data = map(func(x): return x*10, data)
	data.sort()
	var acc = 0
	var i = 0
	
	for x in data:
		data[i] += acc
		acc += data[i]
		i += 1

	return map(func(x): return min(x/10, 1.0), data)

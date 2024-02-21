static func table():
	return {
		"random": 	[[0.4, Idle], [0.5, Random], [0.1, Focus], [0.0, Escape]],
		"idle": 	[[0.3, Idle], [0.7, Random], [0.0, Focus], [0.0, Escape]],
		"escape": 	[[0.1, Idle], [0.2, Random], [0.2, Focus], [0.5, Escape]],
		"focus": 	[[0.2, Idle], [0.2, Random], [0.4, Focus], [0.2, Escape]]
	}

class State:pass

class Idle extends State:
	static func mnemonic() -> String:
		return "idle"

	static func destination_vector(place_holder: Vector2):
		return Vector2(0, 0)

class Random extends State:
	static func mnemonic() -> String:
		return "random"

	static func destination_vector(place_holder: Vector2):
		return Vector2(randi_range(-1, 1), randi_range(-1, 1))

class Escape extends State:
	static func mnemonic() -> String:
		return "escape"

	static func destination_vector(target: Vector2):
		return Vector2(-target.y, -target.x)

class Focus extends State:
	static func mnemonic() -> String:
		return "focus"

	static func destination_vector(target: Vector2):
		return target
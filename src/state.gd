class State: pass

class Idle extends State:
    var mnemonic = "idle"

    func destination_vector(place_holder: Vector2):
        return Vector2(0, 0)

class Random extends State:
    var mnemonic = "random"

    func destination_vector(place_holder: Vector2):
        return Vector2(randi_range(-1, 1), randi_range(-1, 1))

class Escape extends State:
    var mnemonic = "escape"

    func destination_vector(target: Vector2):
        return Vector2(-target.y, -target.x)

class Focus extends State:
    var mnemonic = "focus"

    func destination_vector(target: Vector2):
        return target
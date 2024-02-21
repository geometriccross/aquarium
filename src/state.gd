class State: pass

class Idle extends State:
    func destination_vector(place_holder: Vector2):
        return Vector2(0, 0)

class Random extends State:
    func destination_vector(place_holder: Vector2):
        return Vector2(randi_range(-1, 1), randi_range(-1, 1))

class Escape extends State:
    func destination_vector(target: Vector2):
        return Vector2(-target.y, -target.x)

class Focus extends State:
    func destination_vector(target: Vector2):
        return target
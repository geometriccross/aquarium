extends RigidBody2D

@onready var ray := $point/RayCast2D
const control = preload("res://src/control_utility.gd")

func _physics_process(delta):
	self.apply_force(control.input_vector() * 500, Vector2.ZERO)
	$"ゆ".flip_h = max(-control.input_vector().x, 0)
	var viewport_size = get_viewport_rect().size

extends RigidBody2D

@onready var ray := $point/RayCast2D
const control = preload("res://src/control_utility.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	self.apply_force(control.input_vector() * 500, Vector2.ZERO)
	$"ゆ".flip_h = max(-control.input_vector().x, 0)
	var viewport_size = get_viewport_rect().size

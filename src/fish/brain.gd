extends RigidBody2D

@onready var ray := $point/RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	self.apply_force(input_vector() * 500, Vector2.ZERO)
	$"ゆ".flip_h = max(-input_vector().x, 0)
	var viewport_size = get_viewport_rect().size

func input_vector():
	var up = int(Input.is_key_pressed(KEY_W))
	var down = int(Input.is_key_pressed(KEY_S))
	var left = int(Input.is_key_pressed(KEY_A))
	var right = int(Input.is_key_pressed(KEY_D))
	
	return Vector2(-left + right, -up + down)

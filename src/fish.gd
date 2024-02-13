extends RigidBody2D

@onready var front := $front_sensor
@onready var top := $top_sensor
@onready var low := $low_sensor

@export var manual_control := true
@export var behavior_interval_max := 3
@export var behavior_interval_min := 1

@export var move_speed := 400

var _time := 0.0

const control = preload("res://src/control_utility.gd")

func _physics_process(delta):
	if manual_control:
		self.apply_force(control.input_vector() * move_speed, Vector2.ZERO)
		$"ゆ".flip_h = max(-control.input_vector().x, 0)
	else:
		_time += delta
		if _time >= randi_range(behavior_interval_min, behavior_interval_max):
			behavior_choice([front.hit_info(), top.hit_info(), low.hit_info()])
			_time = 0

func behavior_choice(info):
	match info:
		_:
			var cranial = randi_range(-1, 1)
			$"ゆ".flip_h = max(-cranial, 0)
			self.apply_force(Vector2(cranial, randi_range(-1, 1)) * move_speed, Vector2.ZERO)
			

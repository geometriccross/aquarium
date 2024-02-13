extends RigidBody2D

@onready var front := $front_sensor
@onready var top := $top_sensor
@onready var low := $low_sensor

@export var manual_control := true
@export var behavior_interval_max := 3
@export var behavior_interval_min := 1

@export var move_speed := 400

var _time := 0.0

#左から順にnoraml, escape, focusへと移る確率をあらわした、行動のテーブル
var behavior_table := {
	"random": [0.8, 0, 0.2],
	"escape": [0.3, 0.7, 0],
	"focus": [0.33, 0.33, 0.33]
}

const control = preload("res://src/control_utility.gd")

func _physics_process(delta):
	if manual_control:
		self.apply_force(control.input_vector() * move_speed, Vector2.ZERO)
		$"ゆ".flip_h = max(-control.input_vector().x, 0)
	else:
		_time += delta
		if _time >= randi_range(behavior_interval_min, behavior_interval_max):
			_time = 0
			
func random_walk():
	return Vector2(randi_range(-1, 1), randi_range(-1, 1))

func focus_walk(target: Vector2):
	return Vector2(transform.origin - target)

func escape_walk(target: Vector2):
	var v = focus_walk(target)
	return Vector2(-v.y, -v.x)

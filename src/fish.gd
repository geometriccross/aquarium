extends RigidBody2D

@onready var front := $front_sensor
@onready var top := $top_sensor
@onready var low := $low_sensor

@export var manual_control := true
@export var behavior_interval_max := 3
@export var behavior_interval_min := 1

@export var move_speed := 400

var _time := 0.0
var _RANDOM = "random"
var _ESCAPE = "escape"
var _FOCUS = "focus"
var _state = _RANDOM

#左から順にnoraml, focus, escapeへと移る確率をあらわした、行動のテーブル
var _behavior_table := {
	_RANDOM: [[0.8, random_walk, _RANDOM], [0.2, focus_walk, _FOCUS], [0, escape_walk, _ESCAPE]],
	_ESCAPE: [[0.3, random_walk, _RANDOM], [0, focus_walk, _FOCUS], [0.7, escape_walk, _ESCAPE]],
	_FOCUS: [[0.33, random_walk, _RANDOM], [0.33, focus_walk, _FOCUS], [0.33, escape_walk, _ESCAPE]]
}

const utility = preload("res://src/utility.gd")

func _physics_process(delta):
	if manual_control:
		apply_force(utility.input_vector() * move_speed, Vector2.ZERO)
		$"ゆ".flip_h = max(-utility.input_vector().x, 0)
	else:
		_time += delta
		if _time >= randi_range(behavior_interval_min, behavior_interval_max):
			var f_and_state = behavior_choice(_state, _behavior_table)
			#ここのVector2.LEFTは一時的なもの
			apply_force(f_and_state[0].call(Vector2.LEFT * move_speed), Vector2.ZERO)
			_state = f_and_state[1]
			_time = 0

func behavior_choice(state: String, table: Dictionary) -> Array:
	var result = [random_walk, _RANDOM] #もし何も当たらなかった場合に実行される
	for p_and_f in table[state]:
		if p_and_f[0] > round(randf_range(0, 1.0)):
			result = [p_and_f[1], p_and_f[2]]

	print(result)
	return result

#この関数の引数は使わない
func random_walk(place_holder: Vector2) -> Vector2:
	return Vector2(randi_range(-1, 1), randi_range(-1, 1))

func focus_walk(target: Vector2) -> Vector2:
	return Vector2(transform.origin - target)

func escape_walk(target: Vector2) -> Vector2:
	var v = focus_walk(target)
	return Vector2(-v.y, -v.x)

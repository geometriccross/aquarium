extends RigidBody2D

@onready var front := $front_sensor
@onready var top := $top_sensor
@onready var low := $low_sensor

@export var manual_control := true
@export var behavior_interval_max := 3.0
@export var behavior_interval_min := 1.0

@export var move_speed := 400

var _time := 0.0
var _RANDOM = "random"
var _ESCAPE = "escape"
var _FOCUS = "focus"
var _IDLE = "idle"
var _state = _RANDOM

#左から順にnoraml, focus, escapeへと移る確率をあらわした、行動のテーブル
var _behavior_table := {
	_RANDOM: 	[[0.4, utility.id, _IDLE], [0.5, random_walk, _RANDOM], [0.1, focus_walk, _FOCUS], [0, escape_walk, _ESCAPE]],
	_IDLE: 		[[0.3, utility.id, _IDLE], [0.7, random_walk, _RANDOM], [0, focus_walk, _FOCUS], [0, escape_walk, _ESCAPE]],
	_ESCAPE: 	[[0.1, utility.id, _IDLE], [0.2, random_walk, _RANDOM], [0.2, focus_walk, _FOCUS], [0.5, escape_walk, _ESCAPE]],
	_FOCUS: 	[[0.2, utility.id, _IDLE], [0.2, random_walk, _RANDOM], [0.4, focus_walk, _FOCUS], [0.2, escape_walk, _ESCAPE]]
}

const utility = preload("res://src/utility.gd")

func _physics_process(delta):
	global_rotation = 0 #回転を固定
	if manual_control:
		apply_force(utility.input_vector() * move_speed, Vector2.ZERO)
		image_flip(utility.input_vector().x)

	else:
		_time += delta
		if _time >= randf_range(behavior_interval_min, behavior_interval_max):
			var f_and_state = behavior_choice(_state, _behavior_table)
			var vector = f_and_state[0].call(sensor_perception())
			apply_force(vector * move_speed * 2, Vector2.ZERO)
			image_flip(vector.x)
			_state = f_and_state[1]
			_time = 0

func image_flip(flip_index):
	#ちょうど0の時には、何もせずそのままの向きを保つ
	if flip_index > 0:
		$"ゆ".flip_h = false
	elif flip_index < 0:
		$"ゆ".flip_h = true

func sensor_perception() -> Vector2:
	var ray_num = func(ray): return ((
			int(ray.hit_info()["ray_info"]["top"] != null) + 
			int(ray.hit_info()["ray_info"]["mid"] != null) + 
			int(ray.hit_info()["ray_info"]["low"] != null) 
		)
	)
	
	var area_num = func(area): return int(area.hit_info()["entered_info"] != null)
	
	#エリアにものを検知したら、その方向とは反対向きの値を加える
	return Vector2(
		ray_num.call(front) + -area_num.call(front),
		-ray_num.call(top) + area_num.call(top) + ray_num.call(low) + -area_num.call(low)
	)

func behavior_choice(state: String, table: Dictionary) -> Array:
	var p = randf_range(0.0, 1.0)
	var result = [utility.id, _IDLE] #もし何も当たらなかった場合に実行される
	for p_and_f in table[state]:
		if p_and_f[0] > p:
			result = [p_and_f[1], p_and_f[2]]

	print(result, ", ", p)
	return result

#この関数の引数は使わない
func random_walk(place_holder: Vector2) -> Vector2:
	return Vector2(randi_range(-1, 1), randi_range(-1, 1))

#そのままでも対象へと向かうベクトルになっているため、値をそのまま返す
func focus_walk(target: Vector2) -> Vector2:
	return target

func escape_walk(target: Vector2) -> Vector2:
	return Vector2(-target.y, -target.x)

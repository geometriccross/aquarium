extends RigidBody2D

@onready var front := $front_sensor
@onready var top := $top_sensor
@onready var low := $low_sensor

@export var manual_control := true
@export var behavior_interval_max := 3.0
@export var behavior_interval_min := 1.0

@export var move_speed := 400

const utility = preload("res://src/utility.gd")
const state = preload("res://src/state.gd")

var _time := 0.0
var _state = state.Idle

func _physics_process(delta):
	global_rotation = 0 #回転を固定
	if manual_control:
		apply_force(utility.input_vector() * move_speed, Vector2.ZERO)
		image_flip(utility.input_vector().x)

	else:
		_time += delta
		if _time >= randf_range(behavior_interval_min, behavior_interval_max):
			var fish_state = behavior_choice(_state, state.table())
			var dest_vector = fish_state.destination_vector(sensor_perception())

			apply_force(dest_vector * move_speed * 2, Vector2.ZERO)
			image_flip(dest_vector.x)
	
			_state = fish_state
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

func behavior_choice(fish_state, table: Dictionary):
	var result := state.Idle #もし何も当たらなかった場合に実行される
	for value in table[fish_state.mnemonic()]:
		if value[0] > randf_range(0.0, 1.0):
			result = value[1]

	print(result.mnemonic())
	return result

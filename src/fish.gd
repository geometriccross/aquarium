extends RigidBody2D

@onready var front := $front_sensor
@onready var top := $top_sensor
@onready var low := $low_sensor

@export var manual_control := true
@export var behavior_interval_max := 3
@export var behavior_interval_min := 1

@export var move_speed := 400

var _time := 0.0

#左から順にnoraml, focus, escapeへと移る確率をあらわした、行動のテーブル
var _behavior_table := {
	"random": [[0.8, random_walk], [0.2, focus_walk], [0, escape_walk]],
	"escape": [[0.3, random_walk], [0, focus_walk], [0.7, escape_walk]],
	"focus": [[0.33, random_walk], [0.33, focus_walk], [0.33, escape_walk]]
}

const utility = preload("res://src/utility.gd")

func _physics_process(delta):
	if manual_control:
		self.apply_force(utility.input_vector() * move_speed, Vector2.ZERO)
		$"ゆ".flip_h = max(-utility.input_vector().x, 0)
	else:
		_time += delta
		if _time >= randi_range(behavior_interval_min, behavior_interval_max):
			_time = 0

func behavior_choice(state: String, table: Dictionary) -> Array:
	var p = round(randf_range(0, 1.0))
	var result = ["random", utility.id]
	#行動の確率がすべて同じであった場合、起きる行動が毎回同じになってしまう。
	#テーブルの並びをランダムにすることでこれに対応した
	for percent in table[state].shuffle(): 
		if p > percent: result = percent

	return result

#この関数の引数は使わない
func random_walk(place_holder: Vector2) -> Vector2:
	return Vector2(randi_range(-1, 1), randi_range(-1, 1))

func focus_walk(target: Vector2) -> Vector2:
	return Vector2(transform.origin - target)

func escape_walk(target: Vector2) -> Vector2:
	var v = focus_walk(target)
	return Vector2(-v.y, -v.x)

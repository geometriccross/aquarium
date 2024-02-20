extends Node2D

const fish_scene = preload("res://tscn/fish.tscn")

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var ins = fish_scene.instantiate()
		get_tree().get_root().add_child(ins) #これがないとmainシーンに追加されない
		ins.position = event.position
		ins.manual_control = false

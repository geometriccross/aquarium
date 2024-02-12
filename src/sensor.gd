extends Area2D

@onready var ray_top := $ray_top
@onready var ray_mid := $ray_mid
@onready var ray_low := $ray_low

var entering:Node2D = null

func hit_info():
	return {
		"entered_info": entering,
		"ray_info": {
			"top": ray_top.get_collider(),
			"mid": ray_mid.get_collider(),
			"low": ray_low.get_collider()
		}
	}

func _on_body_entered(body):
	entering = body

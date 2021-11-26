extends Node

func _physics_process(delta):
	$Camera.follow($Player.global_transform.origin)


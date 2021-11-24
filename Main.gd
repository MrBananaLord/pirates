extends Node

func _physics_process(delta):
	$Player.applyWind($Wind.direction, $Wind.strength, delta)
	$Camera.follow($Player.global_transform.origin)

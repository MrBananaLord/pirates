extends Control

var force = Vector3.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	change_wind()
	
func change_wind():
	force.x = rng.randi_range(-10,10)
	force.z = rng.randi_range(-10,10)

func _on_WindChangeTimer_timeout():
	change_wind()

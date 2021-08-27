extends Control

var strength = 20
var direction = 0

func _ready():
	change_direction()

func change_direction():
	strength = [1,2,3][randi() % 3]
	direction = rand_range(0, TAU)
	$Label.text = "Direction: " + str(direction) + " , Strength: " + str(strength)

func _on_WindChangeTimer_timeout():
	change_direction()

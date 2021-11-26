extends CanvasLayer

func _ready():
	$WindForce.antialiased = true
	$WindForce.default_color = Color(255,0,0)
	$WindForce.width = 2.0
	
func _physics_process(delta):
	$Label.text = Wind.force as String
	$WindForce.points = [
		Vector2(20,20),
		Vector2(20,20) + Vector2(Wind.force.x, Wind.force.z)
	]

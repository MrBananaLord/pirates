extends KinematicBody

var playerId = 1
var velocity = Vector3.ZERO

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("sail_up_1"):
		$Ship.sailsUp()
	if Input.is_action_pressed("sail_down_1"):
		$Ship.sailsDown()
	if Input.is_action_pressed("rudder_portside_1"):
		$Ship.rudderTurnStarboard()
	if Input.is_action_pressed("rudder_starboard_1"):
		$Ship.rudderTurnPortside()

	var hullAngle = $Ship/Hull.global_transform.basis.z.angle_to(Wind.force)
	var strength = abs(cos(hullAngle / 2)) * Wind.strength * $Ship.sailFold / 100
	var direction = transform.basis.z.normalized().rotated(transform.basis.y.normalized(), $Ship.rudderAngle * delta)
	var velocity = direction * strength
	
	Debugger.draw("wind", transform.origin + Vector3(0,0,0), Wind.force, Color(255,0,0))
	Debugger.draw("velocity", transform.origin + Vector3(0,0,0), velocity)
		
	rotate_y(- $Ship.rudderAngle * delta)
	move_and_slide(velocity, Vector3.UP)

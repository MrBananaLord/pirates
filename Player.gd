extends KinematicBody

var playerId = 1

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
	if Input.is_action_pressed("sail_clockwise_1"):
		$Ship.sailClockwise()
	if Input.is_action_pressed("sail_counterclockwise_1"):
		$Ship.sailCounterclockwise()


func applyWind(wind, delta):
	var sailAngle = $Ship/Hull/Mast.global_transform.basis.z.angle_to(Vector3.BACK)
	var strength = abs(sin(0 - sailAngle)) * $Ship.sailFold * wind.force

	var direction = transform.basis.z
	var velocity = Vector3.ZERO
	
	velocity.x = strength.x * direction.x * delta
	velocity.z = strength.z * direction.z * delta
	velocity.y -= 1000 * delta
	
	rotate_y(- $Ship.rudderAngle * delta)
	move_and_slide(velocity, Vector3.UP)

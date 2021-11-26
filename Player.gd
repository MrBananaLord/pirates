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
	if Input.is_action_pressed("sail_clockwise_1"):
		$Ship.sailClockwise()
	if Input.is_action_pressed("sail_counterclockwise_1"):
		$Ship.sailCounterclockwise()

#	var sailAngle = $Ship/Hull/Mast.global_transform.basis.z.angle_to(Wind.force)
#	var strength = abs(sin(sailAngle)) * Wind.strength * $Ship.sailFold

	var direction = transform.basis.z.normalized()
	var sailForce = Wind.force * $Ship.sailFold / 10
	
	Debugger.draw("wind", transform.origin + Vector3(0,5,0), Wind.force, Color(255,0,0))

	var angle = $Ship/Hull/Mast.global_transform.basis.z.angle_to(Wind.force)
	var dir = Vector3.ZERO.direction_to($Ship/Hull/Mast.global_transform.basis.z.rotated(Vector3.UP, PI / 2))
	
	if dir.dot(Wind.force) < 0:
		dir = dir.rotated(Vector3.UP, PI)
		
#	Debugger.draw("dir", transform.origin + Vector3(0,5,0), dir, Color(0,0,255))
	var sail = dir.normalized() * $Ship.sailFold / 10 * sin(angle)
	
	Debugger.draw("sail2", transform.origin + Vector3(0,5,0), sail, Color(0,0,255))
	
#	var keel = direction.normalized().rotated(Vector3.UP, PI / 3) * sail.length()
	var keel = ((velocity + Wind.force) * -direction).bounce(direction)
	var newVelocity = Vector3.ZERO.direction_to(direction) * sail.length() + Wind.force
#	newVelocity.y -= 1000 * delta
	velocity = newVelocity
	
#	Debugger.draw("direction", transform.origin + Vector3(0,5,0), Vector3.ZERO.direction_to(direction) * 10, Color(255, 0, 255))
	Debugger.draw("velocity", transform.origin + Vector3(0,5,0), newVelocity)
	Debugger.draw("keel", transform.origin + Vector3(0,5,0), keel, Color(0,255,255))

	rotate_y(- $Ship.rudderAngle / 50)
	move_and_slide(velocity.rotated(transform.basis.y.normalized(), $Ship.rudderAngle * delta), Vector3.UP)

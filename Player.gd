extends KinematicBody

var playerId = 0
var velocity = Vector3.ZERO

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("sail_up_%s" % playerId):
		$Ship.sails_up()
	if Input.is_action_pressed("sail_down_%s" % playerId):
		$Ship.sails_down()
	if Input.is_action_pressed("rudder_portside_%s" % playerId):
		$Ship.rudder_turn_starboard()
	if Input.is_action_pressed("rudder_starboard_%s" % playerId):
		$Ship.rudder_turn_portside()

	var hull_angle = $Ship/Hull.global_transform.basis.z.angle_to(Wind.force)
	var strength = abs(cos(hull_angle / 2)) * Wind.force.length() * $Ship.sail_fold / 100
	var direction = transform.basis.z.normalized().rotated(transform.basis.y.normalized(), $Ship.rudder_angle * delta)
	var velocity = direction * strength
	
	Debugger.draw("wind", transform.origin + Vector3(0,0,0), Wind.force, Color(255,0,0))
	Debugger.draw("velocity", transform.origin + Vector3(0,0,0), velocity)
		
	rotate_y(- $Ship.rudder_angle * delta)
	move_and_slide(velocity, Vector3.UP)

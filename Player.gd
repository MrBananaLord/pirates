extends KinematicBody

const Cannonball = preload("res://Cannonball.tscn")

var playerId = 0
var velocity = Vector3.ZERO
var gravity = Vector3.DOWN * 10

func _ready():
	global_transform.origin.y += 50

func _physics_process(delta):
	if Input.is_action_pressed("sail_up_%s" % playerId):
		$Ship.sails_up()
	if Input.is_action_pressed("sail_down_%s" % playerId):
		$Ship.sails_down()
	if Input.is_action_pressed("rudder_portside_%s" % playerId):
		$Ship.rudder_turn_starboard()
	if Input.is_action_pressed("rudder_starboard_%s" % playerId):
		$Ship.rudder_turn_portside()
	if Input.is_action_just_pressed("fire_portside_%s" % playerId):
		_fire_portside()
	if Input.is_action_just_pressed("fire_starboard_%s" % playerId):
		_fire_starboard()

	var hull_angle = transform.basis.z.angle_to(Wind.force)
	var strength = abs(cos(hull_angle / 2)) * Wind.force.length() * $Ship.sail_fold
	var direction = transform.basis.z.normalized().rotated(transform.basis.y.normalized(), $Ship.rudder_angle * delta)
	velocity.x = (direction * strength).x * delta
	velocity.z = (direction * strength).z * delta
	
	Debugger.draw("wind", transform.origin + Vector3(0,0,0), Wind.force, Color(255,0,0))
	Debugger.draw("velocity", transform.origin + Vector3(0,0,0), velocity)
		
	rotate_y(- $Ship.rudder_angle * delta)
	move_and_slide(velocity, Vector3.UP * 10)
	
	print(is_on_floor())
	if is_on_floor():
		velocity.y = gravity.y * delta
	else: 
		velocity.y += gravity.y * delta

func _fire_starboard():
	_fire(- PI / 2, -2)
	_fire(- PI / 2, 0)
	_fire(- PI / 2, 2)
	
func _fire_portside():
	_fire(PI / 2, -2)
	_fire(PI / 2, 0)
	_fire(PI / 2, 2)

func _fire(angle, offset):
	var ball = Cannonball.instance()
	
	add_child(ball)
	ball.set_as_toplevel(true)
	
	ball.transform.origin += Vector3.UP * 2
	ball.transform.origin += transform.basis.z.normalized() * offset
	var direction = transform.basis.z.normalized().rotated(transform.basis.y.normalized(), angle).rotated(transform.basis.z.normalized(), angle / 5)
#	direction.x *= 20
#	direction.y += 200
	ball.apply_central_impulse(direction * 2500)

extends KinematicBody

var playerId = 1

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("sail_up_1"):
		$Pivot/Ship.sailsUp()
	if Input.is_action_just_pressed("sail_down_1"):
		$Pivot/Ship.sailsDown()
	if Input.is_action_pressed("rudder_portside_1"):
		$Pivot/Ship.rudderTurnStarboard()
	if Input.is_action_pressed("rudder_starboard_1"):
		$Pivot/Ship.rudderTurnPortside()

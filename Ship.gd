extends Spatial

var initial_sail_scale = $Hull/Mast/Sail.scale
var sail_fold = 100 setget set_sail_fold, get_sail_fold
var sail_fold_speed = 1
var rudder_rotation_speed = deg2rad(1)
var mast_rotation_speed = deg2rad(1)
var rudder_angle = 0 setget , get_rudder_angle

func _ready():
	set_sail_fold(0)

func get_sail_fold():
	return sail_fold
	
func get_rudder_angle():
	return rudder_angle

func sails_up():
	if sail_fold + sail_fold_speed <= 100:
		set_sail_fold(sail_fold + sail_fold_speed)
	
func sails_down():
	if sail_fold - sail_fold_speed >= 0:
		set_sail_fold(sail_fold - sail_fold_speed)

func rudder_turn_starboard():	
	if rudder_angle - rudder_rotation_speed >= deg2rad(-45):
		_turnRudderBy(-rudder_rotation_speed)
	
func rudder_turn_portside():
	if rudder_angle + rudder_rotation_speed <= deg2rad(45):
		_turnRudderBy(rudder_rotation_speed)
	
func set_sail_fold(fold):
	sail_fold = fold
	$Hull/Mast/Sail.scale = initial_sail_scale * (fold / 100.0)

func sail_clockwise():
	$Hull/Mast.rotate_y(-mast_rotation_speed)
	
func sail_counterclockwise():
	$Hull/Mast.rotate_y(mast_rotation_speed)

func _turnRudderBy(radAngle):
	rudder_angle += radAngle
	$Hull/Rudder.rotate_y(radAngle)
	

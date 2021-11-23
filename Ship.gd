extends Spatial

var sails = [$"Sail 0", $"Sail 1", $"Sail 2"]
var activeSailIndex = 0
var rudderRotationSpeed = 1
var rudderAngle = 0

func _ready():
	_setActiveSail(1)

func sailsUp():
	if activeSailIndex + 1 < sails.size():
		_setActiveSail(activeSailIndex + 1)

func sailsDown():
	if activeSailIndex - 1 >= 0:
		_setActiveSail(activeSailIndex - 1)

func rudderTurnStarboard():
	if rudderAngle - deg2rad(rudderRotationSpeed) >= deg2rad(-45):
		_turnRudderBy(-deg2rad(rudderRotationSpeed))
	
func rudderTurnPortside():
	if rudderAngle + deg2rad(rudderRotationSpeed) <= deg2rad(45):
		_turnRudderBy(deg2rad(rudderRotationSpeed))
	
func _setActiveSail(index):
	activeSailIndex = index
	 
	for sail in sails: 
		sail.hide()
	
	sails[activeSailIndex].show()

func _turnRudderBy(radAngle):
	rudderAngle += radAngle
	$Rudder.rotate_y(radAngle)

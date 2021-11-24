extends Spatial

var initialSailScale = $Hull/Mast/Sail.scale
var sailFold = 100
var sailFoldSpeed = 1
var rudderRotationSpeed = deg2rad(1)
var mastRotationSpeed = deg2rad(1)
var rudderAngle = 0

func _ready():
	_setSailFold(0)

func sailsUp():
	if sailFold + sailFoldSpeed <= 100:
		_setSailFold(sailFold + sailFoldSpeed)
	
func sailsDown():
	if sailFold - sailFoldSpeed >= 0:
		_setSailFold(sailFold - sailFoldSpeed)

func rudderTurnStarboard():	
	if rudderAngle - rudderRotationSpeed >= deg2rad(-45):
		_turnRudderBy(-rudderRotationSpeed)
	
func rudderTurnPortside():
	if rudderAngle + rudderRotationSpeed <= deg2rad(45):
		_turnRudderBy(rudderRotationSpeed)
	
func _setSailFold(fold):
	sailFold = fold
	print(fold / 100.0)
	$Hull/Mast/Sail.scale = initialSailScale * (fold / 100.0)

func sailClockwise():
	$Hull/Mast.rotate_y(-mastRotationSpeed)
	
func sailCounterclockwise():
	$Hull/Mast.rotate_y(mastRotationSpeed)

func _turnRudderBy(radAngle):
	rudderAngle += radAngle
	$Hull/Rudder.rotate_y(radAngle)

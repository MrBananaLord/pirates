extends Node

func _physics_process(delta):
	$Player.applyWind($Wind, delta)
	$Camera.follow($Player.global_transform.origin)
	
func _ready():
	var vertices = PoolVector3Array()
	vertices.push_back(Vector3(-20, 1, -20))
	vertices.push_back(Vector3(-20, 1, -20) + $Wind.force)
	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, arrays)
	var m = MeshInstance.new()
	m.mesh = arr_mesh
	add_child(m)
	
#func _draw():
#	var path = $Draw.get_simple_path()
#	$Draw.set_material_override(material)
#	$Draw.clear()
#	$Draw.begin(Mesh.PRIMITIVE_POINTS, null)
#	$Draw.add_vertex(Vector3.ZERO)
#	$Draw.add_vertex(Vector3.UP)
#	$Draw.end()
#	$Draw.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
#	for x in path:
#		$Draw.add_vertex(x)
#	$Draw.end()

extends Node

var rays = {}
	
func draw(name, position, vector, color = Color(0,255,0)):
	if get_tree().debug_collisions_hint == false:
		return
		
	if not rays.has(name):
		rays[name] = RayCast.new()
		add_child(rays[name])
	
	var ray = rays[name]
	
	ray.collide_with_bodies = false
	ray.debug_shape_custom_color = color
	ray.debug_shape_thickness = 5.0
	ray.enabled = true
	ray.global_transform.origin = position
	ray.cast_to = vector

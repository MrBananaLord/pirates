extends Camera

func follow(origin):
	global_transform.origin = origin + Vector3(0,30,20)

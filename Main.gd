extends Node

const Player = preload("res://Player.tscn")

var players = {
	0: $Player
}

func _physics_process(delta):
	$Camera.follow($Player.global_transform.origin)
	
	if Input.is_action_just_pressed("join_game_1"):
		if players.has("1"):
			return
			
		var player_1 = Player.instance()
		player_1.name = "player_1"
		player_1.playerId = 1
		players[1] = player_1
		add_child(player_1)

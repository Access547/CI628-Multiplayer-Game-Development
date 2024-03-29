extends Node2D

var characterArray = [preload("res://Scenes/Characters/knight_character.tscn"), preload("res://Scenes/Characters/golem_character.tscn")]
var characterScene


@onready var killFeed = $"CanvasLayer/Kill Feed"


# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for i in GameManager.players:
		characterScene = characterArray[GameManager.players[i].class]
		var currentPlayer = characterScene.instantiate()
		currentPlayer.name = str(GameManager.players[i].id)
		currentPlayer.SetUpPlayer(GameManager.players[i].displayName, GameManager.players[i].id)
		GameManager.playerCharacters.append(currentPlayer)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawner"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1
		



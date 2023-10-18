extends Node2D

var characterArray = [preload("res://Scenes/Characters/knight_character.tscn"), preload("res://Scenes/Characters/golem_character.tscn")]
var characterScene

@onready var killLabel = preload("res://Scenes/UI/Kill.tscn")
@onready var killFeed = $"CanvasLayer/Kill Feed"


# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for i in GameManager.players:
		characterScene = characterArray[GameManager.players[i].class]
		var currentPlayer = characterScene.instantiate()
		currentPlayer.name = str(GameManager.players[i].id)
		currentPlayer.SetUpPlayer(GameManager.players[i].displayName)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawner"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1
		
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



@rpc("any_peer", "call_local", "reliable")
func CreateKillLabel(killer, victim):
	var label = killLabel.instantiate()
	label.Create(killer, victim)
	killFeed.add_child(label)

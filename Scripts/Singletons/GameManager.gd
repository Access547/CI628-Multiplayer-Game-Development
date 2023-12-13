extends Node

var players = {}

var names = ["Cheese", "Bilge", "Demacia", "James", "Jarvan", "Lord Veigar", "Maelstrom", "K'sante", "Nick"]
var playerCharacters = []

@rpc("authority", "call_local")
func Damage(victimID, _damageAmount, damageSource):
	if multiplayer.is_server():
		for i in playerCharacters.size():
			if playerCharacters[i].id == multiplayer.get_remote_sender_id():
				damageSource = playerCharacters[i].displayName
				print(multiplayer.get_remote_sender_id())
				print(damageSource)
			if playerCharacters[i].id == victimID:
				
				playerCharacters[i].healthComponent.damageSource = damageSource
				playerCharacters[i].healthComponent.TakeDamage.rpc_id(victimID, 2, playerCharacters[i].displayName, damageSource)
				


@rpc("any_peer", "call_local")
func CreateKillLabel(killer, victim):
	var killLabel = preload("res://Scenes/UI/Kill.tscn")
	var label = killLabel.instantiate()
	label.Create(killer, victim)
	get_tree().get_first_node_in_group("KillFeed").add_child(label)
	




func _process(_delta):
	if Input.is_action_just_pressed("Random"):
		for i in playerCharacters.size():
			playerCharacters[i].healthComponent.TakeDamage(10, playerCharacters[i].displayName, "god")




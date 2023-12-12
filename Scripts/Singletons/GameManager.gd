extends Node

var players = {}

var names = ["Cheese", "Bilge", "Demacia", "James", "Jarvan", "Lord Veigar", "Maelstrom", "K'sante", "Nick", "Ger"]
var playerCharacters = []

@rpc("authority", "call_local")
func Damage(victimID, _damageAmount, damageSource):
	if multiplayer.is_server():
		for i in playerCharacters.size():
			#print("playerCharacter[i].name: ", playerCharacters[i].id, " str(victimID): ", str(victimID))
			if playerCharacters[i].id == victimID:
				playerCharacters[i].healthComponent.TakeDamage.rpc_id(victimID, 2, playerCharacters[i].displayName, damageSource)
				playerCharacters[i].healthComponent.damageSource = damageSource


@rpc("any_peer", "call_local")
func CreateKillLabel(killer, victim):
	var killLabel = preload("res://Scenes/UI/Kill.tscn")
	var label = killLabel.instantiate()
	label.Create(killer, victim)
	get_tree().get_first_node_in_group("KillFeed").add_child(label)
	




func _process(_delta):
	if Input.is_action_just_pressed("Random"):
		for i in playerCharacters.size():
			playerCharacters[i].healthComponent.TakeDamage(10, "dwa", "god")




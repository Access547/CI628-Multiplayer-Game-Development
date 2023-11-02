extends Node

var players = {}

var names = ["Cheese", "Bilge", "Demacia", "James", "Jarvan", "Lord Veigar", "Maelstrom", "K'sante", "Nick", "Ger"]
var playerCharacters = []

@rpc("authority", "call_local")
func Damage(victimID, damageAmount, damageSource):
	if multiplayer.is_server():
		for i in playerCharacters.size():
			#print("playerCharacter[i].name: ", playerCharacters[i].id, " str(victimID): ", str(victimID))
			if playerCharacters[i].id == victimID:
				playerCharacters[i].healthComponent.TakeDamage.rpc_id(victimID, 2, playerCharacters[i].displayName, damageSource)



func _process(delta):
	if Input.is_action_just_pressed("Random"):
		for i in playerCharacters.size():
			playerCharacters[i].healthComponent.TakeDamage(10, "dwa", "god")

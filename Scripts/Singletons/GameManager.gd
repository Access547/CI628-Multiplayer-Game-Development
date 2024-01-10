extends Node

var players = {}

var names = ["Cheese", "Bilge", "Demacia", "James", "Jarvan", "Lord Veigar", "Maelstrom", "K'sante", "Nick"]
var playerCharacters = []


@rpc("any_peer", "call_local")
func Damage(victim, source, amount, victimName):

	for i in playerCharacters.size():
		if playerCharacters[i].id == victim:
			playerCharacters[i].healthComponent.TakeDamage.rpc_id(victim, 2, source)
			if playerCharacters[i].healthComponent.health <= 1:
				playerCharacters[i].healthComponent.Die.rpc_id(victim)
				playerCharacters[i].healthComponent.CreateKillLabel.rpc(source, playerCharacters[i].displayName)
				
			
			print(str("===================","\nName: ", victim,"\nDamage Taken: ", amount,
	 		"\nDamage Taken from: ", source,"\n==================="))








func _process(_delta):
	if Input.is_action_just_pressed("Random"):
		for i in playerCharacters.size():
			playerCharacters[i].healthComponent.TakeDamage(10, playerCharacters[i].displayName, "god")




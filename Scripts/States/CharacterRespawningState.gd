extends State
class_name CharacterRespawningState

var test = 0
@onready var progress_bar = $"../../ProgressBar"

@export var healthComponent: HealthComponent
@export var respawning: Control

func Enter():
	print("ded")
	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = true
		respawning.timer.start()
		respawning.killed_by.text = str("Killed by: ", healthComponent.damageSource)
		UpdateKD.rpc_id(1)
	progress_bar.visible = false
	sprite.play("Death")
	immune = true

@rpc("any_peer", "call_local")
func UpdateKD():
	GameManager.players[get_parent().get_parent().id]["deaths"] += 1
	#GameManager.players[so]

func Respawn():
	transitioned.emit(self, "CharacterIdleState")
	


func Exit():
	test += 1
	print(str("Respawn Count for ",character.displayName, " ", test))

	
	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = false
		healthComponent.health = healthComponent.maxHealth
		progress_bar.visible = true


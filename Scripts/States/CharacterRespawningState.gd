extends State
class_name CharacterRespawningState

var test = 0
@onready var progress_bar = $"../../ProgressBar"

@export var healthComponent: HealthComponent
@export var respawning: Control

func Enter():
	

	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = true
		respawning.timer.start()
		respawning.killed_by.text = str("Killed by: ", healthComponent.damageSource)

	progress_bar.visible = false
	sprite.play("Death")
	immune = true
	

func Respawn():
	transitioned.emit(self, "CharacterIdleState")
	KillFeed()
	

func KillFeed():
	character.get_parent().CreateKillLabel.rpc(healthComponent.damageSource, character.displayName)

func Exit():
	test += 1
	print(str("test: ", test))

	
	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = false
		immune = false
		healthComponent.health = healthComponent.maxHealth
		#character.position = character.spawnPos
		progress_bar.visible = true


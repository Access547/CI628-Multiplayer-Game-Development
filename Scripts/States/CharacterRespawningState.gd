extends State
class_name CharacterRespawningState


@onready var progress_bar = $"../../ProgressBar"

@export var healthComponent: HealthComponent
@export var respawning: Control

func Enter():
	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = true
		respawning.timer.start()
	progress_bar.visible = false
	sprite.play("Death")
	immune = true
		


func Respawn():
	transitioned.emit(self, "CharacterIdleState")
	print("dwa")

func Exit():
	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = false
		immune = false
		healthComponent.health = healthComponent.maxHealth
		#character.position = character.spawnPos
		progress_bar.visible = true
		

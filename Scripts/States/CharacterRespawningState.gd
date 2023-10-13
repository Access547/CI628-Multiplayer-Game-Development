extends State
class_name CharacterRespawningState


@onready var respawning = $"../../CanvasLayer/Respawning"

@export var healthComponent: HealthComponent

func Enter():
	print("ded")
	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = true
		respawning.timer.start()
		sprite.play("Death")
		healthComponent.immune = true

func Exit():
	if get_parent().get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		respawning.visible = false
		healthComponent.immune = false
		healthComponent.health = healthComponent.maxHealth
		#character.position = character.spawnPos

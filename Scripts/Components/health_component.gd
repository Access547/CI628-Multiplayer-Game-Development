extends Node
class_name HealthComponent


@export var health: int

@export var immune: bool
@export var maxHealth: int
@export var stateMachine: StateMachine

func _ready():
	health = maxHealth
	
	
func TakeDamage(value):
	if !immune:
		health -= value
		if health <= 0:
			if get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().multiplayer.get_unique_id():
				print("hello")
				stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterRespawningState")


func _process(delta):
	if health > maxHealth:
		health = maxHealth

extends Node
class_name HealthComponent




@export var maxHealth: int
@export var stateMachine: StateMachine
@export var health: int


func _ready():
	health = maxHealth
	
	
func TakeDamage(value):
	health -= value
	print(str(self, health))
		


func _process(delta):
	if health > maxHealth:
		health = maxHealth
	if health <= 0:
		#if get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().multiplayer.get_unique_id():
			stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterRespawningState")

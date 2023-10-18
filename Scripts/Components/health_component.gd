extends Node
class_name HealthComponent


var damageSource: String

@export var maxHealth: int
@export var stateMachine: StateMachine
@export var health: int


func _ready():
	health = maxHealth
	

func TakeDamage(value: int, source: String):
	health -= value
	damageSource = source
	print(str("===================","\nName: ", get_parent().displayName,"\nDamage Taken: ", value, "\nHealth Remaining: ", health,
	 "\nDamage Taken from: ", damageSource))

func _process(delta):
	if health > maxHealth:
		health = maxHealth
	if health <= 0:
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterRespawningState")

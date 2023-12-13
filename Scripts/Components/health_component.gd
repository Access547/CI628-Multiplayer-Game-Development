extends Node
class_name HealthComponent


var damageSource: String

@export var maxHealth: int
@export var stateMachine: StateMachine
@export var health: int


func _ready():
	health = maxHealth
	
@rpc("any_peer", "call_local")
func TakeDamage(value: int,victim: String, source: String):
	if !get_parent().stateMachine.currentState.immune:
		health -= value
		damageSource = source
		print(source)
		#PrintDamage(victim, source, value)


func _process(_delta):
	if health > maxHealth:
		health = maxHealth
	if health <= 0:
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterRespawningState")


@rpc("any_peer", "call_local")
func PrintDamage(victim, source, value):
	print(str("===================","\nName: ", victim,"\nDamage Taken: ", value, "\nHealth Remaining: ", health,
	 "\nDamage Taken from: ", source))

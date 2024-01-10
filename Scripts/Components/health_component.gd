extends Node
class_name HealthComponent


var damageSource

@export var maxHealth: int
@export var stateMachine: StateMachine
@export var health: int


func _ready():
	health = maxHealth
	

@rpc("authority", "call_local")
func TakeDamage(amount, source):
	if !stateMachine.isImmuneCheck():
		health -= amount
		damageSource = source

func _process(_delta):
	if health > maxHealth:
		health = maxHealth

@rpc("authority", "call_local")
func Die():
	stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterRespawningState")


@rpc("authority", "call_local")
func CreateKillLabel(killer, victim):
	var killLabel = preload("res://Scenes/UI/Kill.tscn")
	var label = killLabel.instantiate()
	label.Create(killer, victim)
	get_tree().get_first_node_in_group("KillFeed").add_child(label)



extends Node
class_name HealthComponent


var health: int
var immune: bool

@export var maxHealth: int

func _ready():
	health = maxHealth
	
	
func TakeDamage(value):
	if immune:
		value = 0
	health -= value

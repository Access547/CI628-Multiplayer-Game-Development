extends Area2D
class_name HurtboxComponent

@export var healthComponent: HealthComponent
@export var stunComponent: StunComponent

var id

func _ready():
	id = get_parent().multiplayer.get_unique_id()



func Stun(time: int):
	stunComponent.Stun(time)

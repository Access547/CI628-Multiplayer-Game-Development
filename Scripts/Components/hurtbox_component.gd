extends Area2D
class_name HurtboxComponent

@export var healthComponent: HealthComponent
@export var stunComponent: StunComponent

var attackType

func Damage(value):
	#if get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().multiplayer.get_unique_id():
		healthComponent.TakeDamage(value)
		print("hurtbox damage")
			

func Stun(time: int):
	stunComponent.Stun(time)

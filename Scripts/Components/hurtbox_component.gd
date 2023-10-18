extends Area2D
class_name HurtboxComponent

@export var healthComponent: HealthComponent
@export var stunComponent: StunComponent

func Damage(value):
	if healthComponent:
		healthComponent.TakeDamage(value)
		print("dwa")
		

func Stun(time: int):
	stunComponent.Stun(time)

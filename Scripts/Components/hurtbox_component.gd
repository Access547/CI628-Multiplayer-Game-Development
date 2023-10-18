extends Area2D
class_name HurtboxComponent

@export var healthComponent: HealthComponent
@export var stunComponent: StunComponent



func Damage(value: int, source: String):
	if healthComponent:
		healthComponent.TakeDamage(value, source)
		
		
func Stun(time: int):
	stunComponent.Stun(time)

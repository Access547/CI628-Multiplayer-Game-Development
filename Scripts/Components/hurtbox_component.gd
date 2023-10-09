extends Area2D
class_name HurtboxComponent

@export var healthComponent: HealthComponent


func Damage(value):
	if healthComponent:
		healthComponent.TakeDamage(value)

extends State
class_name KnightR


@export var healthComponent: HealthComponent

func Enter():
	sprite.play("Block")
	healthComponent.immune = true
	
func Exit():
	healthComponent.immune = false


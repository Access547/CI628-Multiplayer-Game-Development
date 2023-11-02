extends State
class_name KnightR


@export var healthComponent: HealthComponent

func Enter():
	sprite.play("Block")
	immune = true
	
func Exit():
	immune = false


extends State
class_name KnightE



@export var healthComponent: HealthComponent

func Enter():
	sprite.play("Hurt")
	

func Exit():
	healthComponent.health += 5

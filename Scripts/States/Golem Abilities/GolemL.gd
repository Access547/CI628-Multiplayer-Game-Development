extends State
class_name GolemL


@export var hurtBoxComponent: HurtboxComponent
@export var weapon_slash: AnimatedSprite2D
@export var collision_shape_2d: CollisionShape2D

func Enter():
	sprite.play("Attack")
	character.damage = 2

func Update(delta):
	if sprite.frame == 4:
		collision_shape_2d.disabled = false
		weapon_slash.visible = true
		weapon_slash.play("default")


func Exit():
	collision_shape_2d.disabled = true



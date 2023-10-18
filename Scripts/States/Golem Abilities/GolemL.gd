extends State
class_name GolemL

@export var weapon_slash: AnimatedSprite2D
@onready var collision_shape_2d = $"../../Projectile Rotation/Weapon Slash/Area2D/LCollisonBox"


func Enter():
	sprite.play("Attack")

func Update(delta):
	if sprite.frame == 4:
		weapon_slash.visible = true
		weapon_slash.play("default")
		collision_shape_2d.disabled = false
		

func Exit():
	collision_shape_2d.disabled = true

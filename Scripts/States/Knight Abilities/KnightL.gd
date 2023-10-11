extends State
class_name KnightL


@export var weapon_slash: AnimatedSprite2D
@onready var collision_shape_2d = $"../../Projectile Rotation/Weapon Slash/Area2D/CollisionShape2D"




func Enter():
	weapon_slash.visible = true
	weapon_slash.play("default")
	sprite.play("Attack")
	collision_shape_2d.disabled = false


func Exit():
	collision_shape_2d.disabled = true

extends State
class_name KnightL

@export var multiplayer_synchronizer: MultiplayerSynchronizer
@export var weapon_slash: AnimatedSprite2D
@onready var collision_shape_2d = $"../../Projectile Rotation/Weapon Slash/Area2D/CollisionShape2D"




func Enter():
	sprite.play("Attack")

func Update(_delta):
	if sprite.frame == 2:
		weapon_slash.visible = true
		weapon_slash.play("default")
		collision_shape_2d.disabled = false

func Exit():
	collision_shape_2d.disabled = true




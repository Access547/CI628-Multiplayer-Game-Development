extends State
class_name GolemR

@export var weapon_slash: AnimatedSprite2D
@onready var collision_shape_2d = $"../../GolemRHitbox/RCollisonBox"

func Enter():
	sprite.play("Block")
	
func Update(delta):
	if sprite.frame == 4:
		weapon_slash.visible = true
		weapon_slash.play("default")
		collision_shape_2d.disabled = false
	else:
		collision_shape_2d.disabled = true

func Exit():
	collision_shape_2d.disabled = true

extends State
class_name GolemR

@export var hurtBoxComponent: HurtboxComponent
@export var weapon_slash: AnimatedSprite2D
@export var collision_shape_2d: CollisionShape2D

func Enter():
	sprite.play("Block")
	hurtBoxComponent.attackType = "GolemR"
	

func Update(delta):
	if sprite.frame == 4:
		collision_shape_2d.disabled = false
		weapon_slash.visible = true
		weapon_slash.play("default")


func Attack(area):
	area.Damage(10)
	


func Exit():
	collision_shape_2d.disabled = true

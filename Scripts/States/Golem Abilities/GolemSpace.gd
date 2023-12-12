extends State
class_name GolemSpace

var destination: Vector2

@onready var collision_shape_2d = $"../../GolemSpaceHitbox/SpaceCollisonBox"

func Enter():
	destination = character.get_global_mouse_position()
	sprite.play("Jump")
	
	
func PhysicsUpdate(_delta):
	
	if character.position.distance_to(destination) > 10:
		character.velocity = character.position.direction_to(destination) * 300
	elif character.position.distance_to(destination) < 10:
		transitioned.emit(self, "CharacterIdleState")


func Exit():
	
	collision_shape_2d.disabled = false
	await get_tree().create_timer(0.1).timeout
	collision_shape_2d.disabled = true

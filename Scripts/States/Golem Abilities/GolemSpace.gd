extends State
class_name GolemSpace

var destination: Vector2

@onready var collision_shape_2d = $"../../GolemSpaceHitbox/SpaceCollisonBox"

func Enter():
	destination = character.get_global_mouse_position()
	sprite.play("Jump")
	
	
func PhysicsUpdate(delta):
	
	if character.position.distance_to(destination) > 10:
		character.velocity = character.position.direction_to(destination) * 300
	elif character.position.distance_to(destination) < 10:
		transitioned.emit(self, "CharacterIdleState")


func Exit():
	collision_shape_2d.disabled = false
	collision_shape_2d.disabled = true

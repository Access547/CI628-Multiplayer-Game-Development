extends State
class_name CharacterIdleState




func Enter():
	sprite.play("Idle")


func PhysicsUpdate(delta):
	if character.velocity != Vector2.ZERO:
		transitioned.emit(self, "CharacterMoveState")

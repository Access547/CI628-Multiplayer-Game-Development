extends State
class_name CharacterMoveState




func Enter():
	sprite.play("Walk")


func PhysicsUpdate(_delta):
	if character.velocity == Vector2.ZERO:
		transitioned.emit(self, "CharacterIdleState")


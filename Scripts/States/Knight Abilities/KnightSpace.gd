extends State
class_name KnightSpace


var direction

@export var dashSpeed: float


func Enter():
	character.SPEED = dashSpeed


func Update(delta):
	
	direction = character.velocity.normalized()
	character.velocity = direction * character.SPEED
	character.SPEED -= 40
	if character.SPEED <= 99:
		transitioned.emit(self, "CharacterIdleState")
		
func Exit():
	character.SPEED = 100

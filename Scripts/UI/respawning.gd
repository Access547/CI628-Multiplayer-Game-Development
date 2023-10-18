extends Control

@onready var time_left = $"Time left"
@onready var killed_by = $"Killed by"
@onready var timer = $Timer
@export var stateMachine: StateMachine

func _process(delta):
	time_left.text = str("Respawning in: ", int(timer.time_left))


func _on_timer_timeout():
	if stateMachine.currentState is CharacterRespawningState:
		stateMachine.currentState.Respawn()

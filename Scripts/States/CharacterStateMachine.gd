extends Node

class_name StateMachine

@export var character: CharacterBody2D
@export var sprite: AnimatedSprite2D

@export var initialState: State

var currentState
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transition)
			child.character = character
			child.sprite = sprite

	currentState = initialState
	
func _process(delta):
	if currentState:
		currentState.Update(delta)

func _physics_process(delta):
	if currentState:
		currentState.PhysicsUpdate(delta)


func on_child_transition(state, newStateName):
	if get_parent().multiplayer_synchronizer.get_multiplayer_authority() == get_parent().get_parent().multiplayer.get_unique_id():
		if state != currentState:
			return
			
		var newState = states.get(newStateName)
		if !newState:
			return
			
		if currentState:
			currentState.Exit()
			
		newState.Enter()
		
		currentState = newState


func canMoveCheck():
	return currentState.canMove

func isImmuneCheck():
	return currentState.immune

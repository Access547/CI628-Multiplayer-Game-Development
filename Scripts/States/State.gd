extends Node

class_name State


var character: CharacterBody2D
var sprite: AnimatedSprite2D

@export var canMove: bool = true

signal transitioned

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func PhysicsUpdate(_delta: float):
	pass



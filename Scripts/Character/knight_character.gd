extends PC


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		if area != self.get_node("Hurtbox Component"):
			GameManager.Damage.rpc_id(1, area.get_parent().id, 2, self.displayName)

func _on_sprite_animation_finished():
	if sprite.animation == "Block":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")
	if sprite.animation == "Attack":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")
	if sprite.animation == "Hurt":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")


func _on_weapon_slash_animation_finished():
	weapon_slash.visible = false


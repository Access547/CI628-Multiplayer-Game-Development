extends PC


func _on_area_2d_area_entered(area):
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		if area.is_in_group("Player"):
			if area != self.get_node("Hurtbox Component"):
				var whoIHit = area.get_parent()
				if !whoIHit.stateMachine.isImmuneCheck():
					print(str(whoIHit.stateMachine.isImmuneCheck()))
					GameManager.Damage.rpc_id(1, whoIHit.id, displayName, 2, whoIHit.name)


func _on_sprite_animation_finished():
	if sprite.animation == "Block":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")
	if sprite.animation == "Attack":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")
	if sprite.animation == "Hurt":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")


func _on_weapon_slash_animation_finished():
	weapon_slash.visible = false


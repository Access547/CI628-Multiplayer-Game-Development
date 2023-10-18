extends PC

var eArray = []
var stompsLeft = 5


func _on_sprite_animation_finished():
	if sprite.animation == "Block":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")
	if sprite.animation == "Attack":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")
	if sprite.animation == "Hurt":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")




func _on_weapon_slash_animation_finished():
	weapon_slash.visible = false

#Weapon slash area
func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		if area != self.get_node("Hurtbox Component"):
			area.Damage(3, displayName)
			if stunComponent.canBeStunned:
				area.Stun(120)


func _on_golem_r_hitbox_area_entered(area):
		if area.is_in_group("Player"):
			if area != self.get_node("Hurtbox Component"):
				print("dwa2")
				area.Damage(5, displayName)
				area.get_parent().Knockback(1250, area.get_parent().position - position)


func _on_golem_space_hitbox_area_entered(area):
		if area.is_in_group("Player"):
			if area != self.get_node("Hurtbox Component"):
				area.Damage(2, displayName)
				area.get_parent().Knockback(1000, area.get_parent().position - position)


func _on_golem_e_hitbox_area_entered(area):
	if area.is_in_group("Player"):
		if area != self.get_node("Hurtbox Component"):
			eArray.append(area)
			print("hello")


func _on_golem_e_hitbox_area_exited(area):
	eArray.erase(area)




func _on_e_timer_timeout():
	
	for area in eArray:
		area.Damage(3, displayName)
	stompsLeft -= 1
	if stompsLeft <= 0:
		$GolemEHitbox/ETimer.stop()
		$GolemEHitbox/ECollisonBox.disabled = true
		eArray.clear()
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")

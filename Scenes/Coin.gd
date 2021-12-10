extends Area2D

var collided = false

signal coin_collected

func _on_Coin_body_entered(body):
	if collided == false:
		collided = true
		emit_signal("coin_collected")
		body.play_coin_sound()
		$AnimationPlayer.play("collected")
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()

extends Cannon


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("pirate"):
		targets.append(body)
		select_target()
		%ShootTimer.start()

func _on_shoot_timer_timeout() -> void:
	shoot()

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("pirate"):
		var exited_body = targets.find(body)
		targets.remove_at(exited_body)
		select_target()


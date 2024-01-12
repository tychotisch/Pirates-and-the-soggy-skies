extends PathFollow2D


func _physics_process(delta: float) -> void:
	var speed := 90
	progress += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	Events.emit_signal("pirate_escaped", -1)
	queue_free()

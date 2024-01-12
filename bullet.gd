extends Area2D
class_name Bullet

var speed := 600
var damage_amount := 1

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("pirate"):
		body.set_damage(damage_amount)
	queue_free()

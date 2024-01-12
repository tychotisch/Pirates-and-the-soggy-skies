extends Node2D
class_name Cannon

@export var resell_value := 75
var target = null
var targets := []


func _ready() -> void:
	Events.connect("tower_sold", tower_sold)
	Events.connect("set_range_invisible", set_range_invisible)
	add_to_group("cannon")

func _physics_process(_delta: float) -> void:
	if target:
		rotation = position.angle_to_point(target.global_position)
	else:
		%ShootTimer.stop()

func select_target() -> void:
	if targets:
		target = targets[0]
	else:
		target = null

func toggle_range_visible() -> void:
	%ShowRange.visible = !%ShowRange.visible
	
func set_range_invisible() -> void:
	%ShowRange.visible = false

func shoot() -> void:
	var bullet = preload("res://Bullet/Bullet.tscn")
	var cannonbal = bullet.instantiate()
	get_tree().root.add_child(cannonbal)
	cannonbal.global_transform = %CannonballSpawn.global_transform

func tower_sold():
	if %ShowRange.visible:
		queue_free()

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

func _on_placement_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
			toggle_range_visible()
			Events.emit_signal("tower_selected", resell_value)

extends Area2D
class_name Placement

var overlapping := false

func _on_area_entered(area: Area2D) -> void:
	if get_overlapping_areas().size() >= 2:
		overlapping = true
	if area.is_in_group("cannon") and !overlapping:
		Events.emit_signal("can_place", true)

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("cannon"):
		Events.emit_signal("can_place", false)


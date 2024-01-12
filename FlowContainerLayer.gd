extends FlowContainer



func _ready() -> void:
	spawn_cannon_mobile_panel()
	spawn_cannon_fixed_panel()

func spawn_cannon_mobile_panel() -> void:
	var cannon_to_instance = preload("res://Panels/cannon_panel_mobile.tscn")
	var cannon = cannon_to_instance.instantiate()
	add_child(cannon)

func spawn_cannon_fixed_panel() -> void:
	var cannon_to_instance = preload("res://Panels/SuperCannonPanel.tscn")
	var cannon = cannon_to_instance.instantiate()
	add_child(cannon)

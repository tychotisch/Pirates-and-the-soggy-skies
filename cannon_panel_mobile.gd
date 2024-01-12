extends Panel
class_name CannonPanel

@export var cannon_mobile = preload("res://Cannon/cannon_mobile.tscn")
@onready var path = get_tree().get_root().get_node("Main")
@export var purchase_value := 150

var placement_zone := false
var money

func _ready() -> void:
	Events.connect("can_place", set_placement_zone)
	Events.connect("current_money", set_money)
	
func set_money(value) -> void:
	money = value

func set_placement_zone(value: bool) -> void:
	placement_zone = value

func _on_gui_input(event: InputEvent) -> void:
	var mouse_pos := get_global_mouse_position()
	var cannon = cannon_mobile.instantiate()
	if money >= purchase_value:
		if event is InputEventMouseButton and event.button_mask == 1:
			add_child(cannon)
			if placement_zone:
				cannon.global_position = mouse_pos
				placement_zone = false
				#cannon.process_mode = Node.PROCESS_MODE_DISABLED

		elif event is InputEventMouseMotion and event.button_mask == 1:
			if get_child_count() > 1:
				get_child(1).global_position = mouse_pos

		elif event is InputEventMouseButton and event.button_mask == 0:
			if get_child_count() > 1:
				remove_temp_cannon()
			if placement_zone:
				path.add_child(cannon)
				cannon.global_position = mouse_pos
				cannon.get_node("ShowRange").hide()
				placement_zone = false
				Events.emit_signal("tower_bought", -purchase_value)
				#queue_free()
		else:
			if get_child_count() > 1:
				remove_temp_cannon()

func remove_temp_cannon() -> void:
	get_child(1).queue_free()



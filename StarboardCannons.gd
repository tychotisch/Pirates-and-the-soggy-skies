extends Node2D


var bullet_spawn_locations := []

func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			bullet_spawn_locations.append(i)

func evacuate_crew(amount) -> void:
	for i in amount:
		randomize()
		var pos_to_spawn = bullet_spawn_locations[randi() % bullet_spawn_locations.size()]
		var crew := preload("res://Crew/crew.tscn")
		var crew_member_to_evacuate = crew.instantiate()
		get_tree().root.add_child(crew_member_to_evacuate)
		crew_member_to_evacuate.global_transform = pos_to_spawn.global_transform

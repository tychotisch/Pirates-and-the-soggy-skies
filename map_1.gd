extends TileMap
class_name Map

@export var waves := 5
@export var start_enemy := 10
@export var enemy_interval := 1.6
@onready var path = get_node("MapPath")
@onready var path2 = get_node("MapPath2")
@onready var path3 = get_node("MapPath3")
@onready var path4 = get_node("MapPath4")
@onready var paths := [path, path2, path3, path4]

var wave := 0
var enemy_left_to_spawn := 0
var enemy_to_spawn := []

func _ready() -> void:
	%WaveTimer.start()
	set_waves()

func set_waves() -> void:
	for enemy in waves:
		enemy_to_spawn.append(start_enemy + 10)
		start_enemy += 10

func spawn_pirate_ship() -> void:
	randomize()
	var path_to_spawn = paths[randi() % paths.size()]
	var pirate_to_instance = preload("res://Enemy/pirate_ship_on_path.tscn")
	var pirate = pirate_to_instance.instantiate()
	path_to_spawn.add_child(pirate)

func _on_spawn_timer_timeout() -> void:
	spawn_pirate_ship()
	enemy_left_to_spawn -= 1
	if enemy_left_to_spawn <= 0:
		%SpawnTimer.stop()
		wave += 1
		Events.emit_signal("wave_increase", 1)

		if wave <= len(enemy_to_spawn) -1 :
			%WaveTimer.start()
		else:
			%WaveTimer.stop()
			%SpawnTimer.stop()
			Events.emit_signal("all_waves_spawned")

func _on_wave_timer_timeout() -> void:
	enemy_left_to_spawn = enemy_to_spawn[wave]
	%SpawnTimer.wait_time = enemy_interval
	%SpawnTimer.start()

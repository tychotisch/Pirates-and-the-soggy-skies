extends Path2D


var wave := 0
var enemy_left_to_spawn := 0
var enemy_to_spawn := [10, 15, 20]
var enemy_interval := [1.5, 2.0, 2.5]

func _ready() -> void:
	%WaveTimer.start()

func spawn_pirate_ship() -> void:
	var pirate_to_instance = preload("res://Enemy/pirate_ship_on_path.tscn")
	var pirate = pirate_to_instance.instantiate()
	add_child(pirate)

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
			print("all waves spawned")

func _on_wave_timer_timeout() -> void:
	enemy_left_to_spawn = enemy_to_spawn[wave]
	%SpawnTimer.wait_time = enemy_interval[wave]
	%SpawnTimer.start()

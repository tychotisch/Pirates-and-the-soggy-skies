extends Node2D

@onready var lives_label: Label = $OnscreenInfo/Lives/LivesLabel
@onready var money_label: Label = $OnscreenInfo/Gold/MoneyLabel
@onready var wave_label: Label = $OnscreenInfo/Wave/WaveLabel

var lives := 10
var money := 500
var sell_amount := 0
var wave := 0
var check_pirates_group := false
var level := 1

func _ready() -> void:
	show_menu()
	set_lives(0)
	set_money(0)
	set_wave_label(0)
	Events.connect("pirate_escaped", set_lives)
	Events.connect("pirate_died", set_money)
	Events.connect("wave_increase", set_wave_label)
	Events.connect("tower_bought", set_money)
	Events.connect("tower_selected", on_tower_selected)
	Events.connect("all_waves_spawned", check_pirates_onscreen)
	%Upgrades.hide()
	%WinLabel.hide()
	%GameOverLabel.hide()
	%NextLevelButton.hide()

func _process(_delta: float) -> void:
	if check_pirates_group:
		check_pirates_onscreen()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		show_menu()

func show_menu() -> void:
	%Menu.show()
	get_tree().paused = true

func set_lives(value) -> void:
	lives += value
	lives = clamp(lives, 0, 10)
	lives_label.text = "X %s" % lives
	if lives == 0:
		set_gameover_state()

func set_money(value) -> void:
	money += value
	money_label.text = "X %s" % money
	Events.emit_signal("current_money", money)

func set_wave_label(value) -> void:
	wave += value
	wave_label.text = "Wave: %s" % wave

func set_next_level():
	var map_1 = $Map_1
	var new_level = preload("res://Maps/map_2.tscn")
	var map2 = new_level.instantiate()
	get_tree().root.add_child(map2)
	map_1.queue_free()
	clear_towers()
	level += 1

func clear_towers() -> void:
	for tower in get_tree().get_nodes_in_group("cannon"):
		tower.queue_free()

func on_tower_selected(value) -> void:
	sell_amount = value
	%Upgrades.show()

#function gets called by the map after all waves have spawned.
func check_pirates_onscreen() -> void:
	check_pirates_group = true
	var amount_of_pirates = get_tree().get_nodes_in_group("pirate").size()
	if amount_of_pirates == 0:
		set_win_state()

func set_win_state() -> void:
	check_pirates_group = false
	%AnimationPlayer.play("win")
	await %AnimationPlayer.animation_finished
	show_menu()
	%StartButton.hide()
	if !level == 2:
		%NextLevelButton.show()

func set_gameover_state() -> void:
	%AnimationPlayer.play("game_over")
	show_menu()
	%StartButton.hide()

func _on_sell_pressed() -> void:
	set_money(sell_amount)
	Events.emit_signal("tower_sold")
	%Upgrades.hide()

func _on_close_pressed() -> void:
	%Upgrades.hide()
	Events.emit_signal("set_range_invisible")

func _on_start_button_pressed() -> void:
	%Menu.hide()
	get_tree().paused = false

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	%Menu.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_next_level_button_pressed() -> void:
	set_next_level()
	%NextLevelButton.hide()
	show_menu()
	%StartButton.show()
	set_lives(0)
	wave = 0
	set_wave_label(0)
	set_money(500)


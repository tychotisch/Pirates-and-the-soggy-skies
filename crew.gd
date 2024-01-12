extends Node2D

var speed := 200
var travelled_distance := 0.0
var damage_amount := 1

var crew_1 := preload("res://Objects/crew (1).png")
var crew_2 := preload("res://Objects/crew (2).png")
var crew_3 := preload("res://Objects/crew (3).png")
var crew_4 := preload("res://Objects/crew (4).png")
var crew_5 := preload("res://Objects/crew (5).png")
var crew_6 := preload("res://Objects/crew (6).png")
var crew_list := [crew_1, crew_2, crew_3, crew_4, crew_5, crew_6]

func _ready() -> void:
	set_crew_sprite()

func set_crew_sprite() -> void:
	randomize()
	var crew_member = crew_list[randi() % crew_list.size()]
	%Sprite2D.texture = crew_member

func _physics_process(delta: float) -> void:
	var max_range := 50
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > max_range:
		queue_free()

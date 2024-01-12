extends Sprite2D

var damage := 0
var ship_0_normal := preload("res://Ships/ship (1).png")
var ship_0_damaged := preload("res://Ships/ship (7).png")
var ship_0_very_damaged := preload("res://Ships/ship (13).png")
var ship_0_dead := preload("res://Ships/ship (19).png")
var ship_1_normal := preload("res://Ships/ship (2).png")
var ship_1_damaged := preload("res://Ships/ship (8).png")
var ship_1_very_damaged := preload("res://Ships/ship (14).png")
var ship_1_dead := preload("res://Ships/ship (20).png")
var ship_2_normal := preload("res://Ships/ship (3).png")
var ship_2_damaged := preload("res://Ships/ship (9).png")
var ship_2_very_damaged := preload("res://Ships/ship (15).png")
var ship_2_dead := preload("res://Ships/ship (21).png")
var ship_3_normal := preload("res://Ships/ship (4).png")
var ship_3_damaged := preload("res://Ships/ship (10).png")
var ship_3_very_damaged := preload("res://Ships/ship (16).png")
var ship_3_dead := preload("res://Ships/ship (22).png")
var ship_4_normal := preload("res://Ships/ship (6).png")
var ship_4_damaged := preload("res://Ships/ship (12).png")
var ship_4_very_damaged := preload("res://Ships/ship (18).png")
var ship_4_dead := preload("res://Ships/ship (24).png")
var ship_5_normal := preload("res://Ships/ship (5).png")
var ship_5_damaged := preload("res://Ships/ship (11).png")
var ship_5_very_damaged := preload("res://Ships/ship (17).png")
var ship_5_dead := preload("res://Ships/ship (23).png")
var ship_0 := [ship_0_normal, ship_0_damaged, ship_0_very_damaged, ship_0_dead]
var ship_1 := [ship_1_normal, ship_1_damaged, ship_1_very_damaged, ship_1_dead]
var ship_2 := [ship_2_normal, ship_2_damaged, ship_2_very_damaged, ship_2_dead]
var ship_3 := [ship_3_normal, ship_3_damaged, ship_3_very_damaged, ship_3_dead]
var ship_4 := [ship_4_normal, ship_4_damaged, ship_4_very_damaged, ship_4_dead]
var ship_5 := [ship_5_normal, ship_5_damaged, ship_5_very_damaged, ship_5_dead]
var ships := [ship_0, ship_1, ship_2, ship_3, ship_4, ship_5]
var ship

func _ready() -> void:
	set_ship_sprite()

func set_ship_sprite() -> void:
	randomize()
	ship = ships[randi() % ships.size()]
	texture = ship[0]

func set_damage_sprite(value) -> void:
	damage += value
	damage = clamp(damage, 0, 3)
	texture = ship[damage]

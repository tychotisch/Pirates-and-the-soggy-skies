extends CharacterBody2D

var alive := true
var damage := 0

func _ready() -> void:
	add_to_group("pirate")

func _physics_process(_delta: float) -> void:
	if damage == 3 and alive:
		eject_crew()

func set_damage(value) -> void:
	damage += value
	damage = clamp(damage, 0, 3)
	%Sprite.set_damage_sprite(value)

func eject_crew() -> void:
		%FireParticles/CPUParticles2D.emitting = true
		var max_amount_to_eject := 5
		%PortCannons.evacuate_crew(randi() % max_amount_to_eject)
		%StarboardCannons.evacuate_crew(randi() % max_amount_to_eject)
		alive = false
		%AnimationPlayer.play("death")
		await %AnimationPlayer.animation_finished
		Events.emit_signal("pirate_died", 10)
		remove_from_group("pirate")
		get_parent().queue_free()
		

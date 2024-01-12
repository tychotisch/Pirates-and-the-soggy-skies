extends Node

# Auto-loaded node that only emits signals.
# Any node in the game can use it to emit signals, like so:
		# Events.emit_signal("mob_died", 10)

# Any node in the game can connect to the events:

	#Events.connect("mob_died", update_score)

# This allows nodes to easily communicate accross the project without needing to
# know about each other. We mainly use it to update the heads-up display, like
# the player's health and score

signal can_place
signal set_range_invisible
signal pirate_escaped
signal all_waves_spawned
signal pirate_died(value)
signal wave_increase(value)
signal tower_bought(value)
signal tower_sold()
signal current_money(value)
signal tower_selected(value)

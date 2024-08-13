extends Node2D

enum State{
	PATROL,
	ENGAGE
}

signal state_changed(new_state)

@onready var detection_zone = $DetectionZone
var current_state: int = State.PATROL : set = set_state
#var player: Player = null



func set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func _on_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		#player = body

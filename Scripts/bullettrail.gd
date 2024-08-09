extends Trails

@export var child_start_color : Color = Color(1, 0, 0)  # Default to yellow
@export var child_end_color : Color = Color(1, 1, 1)    # Default to blue

func _ready():
	# Optionally set or override gradient colors here if needed
	START_COLOR = child_start_color
	END_COLOR = child_end_color
	update_gradient()

func _get_position():
	return get_parent().position

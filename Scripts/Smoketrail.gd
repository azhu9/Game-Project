extends Line2D
class_name Trails

var queue : Array = []
@export var MAX_LENGTH : int = 5
@export var BULLET_WIDTH : float = 1.0
@export var START_COLOR : Color = Color(1, 0, 0)  # Default to red
@export var END_COLOR : Color = Color(1, 1, 1)    # Default to white

func _ready():
	update_gradient()

func _process(_delta):
	var pos = _get_position()
	
	queue.push_front(pos)
	
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
		
	clear_points()
	
	# Set the width of the Line2D
	width = BULLET_WIDTH
	
	for point in queue:
		add_point(point)

func _get_position():
	return Vector2.ZERO  # Default implementation, should be overridden by children if needed

func update_gradient():
	var gradient = Gradient.new()
	gradient.add_point(0.0, START_COLOR)
	gradient.add_point(0.99, END_COLOR)
	
	self.gradient = gradient

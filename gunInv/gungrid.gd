extends GridContainer

@onready var slots = get_children()



var current_index: int:
	set(value):
		current_index = value
		reset_focus()
		set_focus()

func _ready():
	current_index = 0

func _process(delta):
	
	if Input.is_action_pressed("1"): #pistol
		current_index = 0
	if Input.is_action_pressed("2"): #rifle
		current_index = 1
	if Input.is_action_pressed("3"): #shotgun
		current_index = 2
	if Input.is_action_pressed("4"): #awp
		current_index = 3
	if Input.is_action_pressed("5"):
		current_index = 4

func reset_focus():
	for slot in slots:
		slot.set_process_input(false)

func set_focus():
	get_child(current_index).grab_focus()
	get_child(current_index).set_process_input(true)

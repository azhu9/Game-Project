extends CharacterBody2D

var mouse_button_pressed:bool

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	if velocity.length() > 0.0 and mouse_button_pressed == false:
		rotation = velocity.angle()
	
"""
func _input(event):
	if event.is_action_pressed("click"):
		mouse_button_pressed = true
		rotate(get_angle_to(get_global_mouse_position()))
		await get_tree().create_timer(0.1).timeout
		mouse_button_pressed = false
	"""
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():  # Mouse button down.
			mouse_button_pressed = true
		elif not event.is_pressed():  # Mouse button released.
			mouse_button_pressed = false

func _process(delta):
	if mouse_button_pressed: 
		rotate(get_angle_to(get_global_mouse_position()))

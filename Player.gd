extends CharacterBody2D

var mouse_button_pressed:bool

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	if velocity.length() > 0.0 and mouse_button_pressed == false:
		rotation = velocity.angle()
		## later version should have no rotation- should instead
		## change costumes. This will also avoid the weird direction
		## changes when shooting
	

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():  # Mouse button down.
			mouse_button_pressed = true
		elif not event.is_pressed():  # Mouse button released.
			mouse_button_pressed = false

func _process(delta):
	if mouse_button_pressed: 
		rotate(get_angle_to(get_global_mouse_position()))

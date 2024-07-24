extends CharacterBody2D

var shooting:bool

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	if velocity.length() > 0.0 and shooting == false:
		rotation = velocity.angle()
	

func _input(event):
	if event.is_action_pressed("click"):
		shooting = true
		rotate(get_angle_to(get_global_mouse_position()))
		await get_tree().create_timer(0.1).timeout
		shooting = false

extends CharacterBody2D

var mouse_button_pressed:bool
#variables for camera zoom
var zoom_minimum = Vector2(5.00001, 5.00001)
var zoom_maximum = Vector2(2.00001, 2.00001)
var zoom_speed = Vector2(.100001, .100001)

@onready var camera = $Camera2D

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 300
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
			if event.button_index == MOUSE_BUTTON_WHEEL_UP: #Zoom in when MW up
				if camera.zoom < zoom_minimum:
					camera.zoom += zoom_speed
					pass
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN: #Zoom in when MW down
				if camera.zoom > zoom_maximum:
					camera.zoom -= zoom_speed
		elif not event.is_pressed():  # Mouse button released.
			mouse_button_pressed = false

func _process(delta):
	if mouse_button_pressed: 
		rotate(get_angle_to(get_global_mouse_position()))

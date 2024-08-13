extends CharacterBody2D

var mouse_button_pressed:bool
#variables for camera zoom
var zoom_minimum = Vector2(5.00001, 5.00001)
var zoom_maximum = Vector2(1.00001, 1.00001)
var zoom_speed = Vector2(.100001, .100001)

var walk_speed = 200
var sprint_speed = walk_speed * 1.5

@onready var camera = $Camera2D

@export var inv: Inv

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	if Input.is_action_pressed("sprint"):
		velocity = direction * sprint_speed
		move_and_slide()
	else:
		velocity = direction * walk_speed
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

func _on_gun_manual_shot():
	rotate(get_angle_to(get_global_mouse_position()))

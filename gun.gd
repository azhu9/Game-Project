extends Area2D
signal manual_shot
signal pistol
signal rifle
signal shotgun

const BULLET = preload("res://bullet.tscn")
static var gun_id: int
static var gun_type: int
static var auto_fire: bool
static var bullet_count: int
static var spray_angle: float
static var bullet_speed: int
static var bullet_range: int
static var reload_time: float

static var loaded: bool = true


func shoot_1(): #shoots 1 bullet at a time
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	new_bullet.load_gun(bullet_speed, bullet_range)
	%ShootingPoint.add_child(new_bullet)
func shoot_2(): #shoots multiple bullets
	var angle_increment = deg_to_rad(spray_angle / (bullet_count - 1))  # Angle increment in radians
	var start_angle = -deg_to_rad(spray_angle / 2)
	for i in range(0,bullet_count,1):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation + start_angle + (i*angle_increment)
		new_bullet.load_gun(bullet_speed, bullet_range-((i%3)*10))
		%ShootingPoint.add_child(new_bullet)

# autoshot
func _on_timer_timeout():
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and auto_fire):
		match gun_type:
			1:
				shoot_1()
			2:
				shoot_2()
			_:
				pass

# click to shoot
func _input(event):
	if event.is_action_pressed("click") and !auto_fire and loaded:
		emit_signal("manual_shot")
		match gun_type:
			1:
				shoot_1()
			2:
				shoot_2()
			_:
				pass
		loaded = false
		await get_tree().create_timer(reload_time).timeout
		loaded = true
		

func _on_pistol():
	gun_id = 1
	gun_type = 1
	auto_fire = false
	bullet_count = 1
	spray_angle = 0.0
	bullet_speed = 1000
	bullet_range = 10000
	reload_time = 0.2
func _on_rifle():
	gun_id = 2
	gun_type = 1
	auto_fire = true
	bullet_count = 1
	spray_angle = 0.0
	bullet_speed = 1000
	bullet_range = 10000
	reload_time = 0.0
func _on_shotgun():
	gun_id = 3
	gun_type = 2
	auto_fire = false
	bullet_count = 12
	spray_angle = 30
	bullet_speed = 1500
	bullet_range = 300
	reload_time = 1.0


func _process(delta):
	if Input.is_action_pressed("1"): #pistol
		emit_signal("pistol")
	if Input.is_action_pressed("2"): #rifle
		emit_signal("rifle")
	if Input.is_action_pressed("3"): #shotgun
		emit_signal("shotgun")


func _on_manual_shot():
	pass # Replace with function body.

# when adding a gun, there are 4 places the gun needs to be added:
# ctrl f 'point 1', 'point 2', etc to find
extends Area2D
signal manual_shot
signal pistol
signal rifle
signal shotgun
signal awp

const BULLET = preload("res://Scenes/bullet.tscn")
const BULLET_TRAIL = preload("res://Scenes/smoketrail.tscn")  # Path to the bullet trail scene



static var gun_id: int #gun's unique id
static var gun_type: int #1=one bullet 2=multiple bullets
static var auto_fire: bool #self explanatory
static var bullet_spread: bool #is there bullet spread?
static var bullet_count: int #bullets per shot (only for guntype 2)
static var spray_angle: float #DO NOT SET TO 0 UNLESS bullet_spread = false(only for guntype 2)
static var bullet_speed: int #self explanatory
static var bullet_range: int #distance bullets travel
static var reload_time: float #min time between shots
static var trail_enabled: bool #determines if bullets have a trail or not

var current_loaded: bool = true

var rng = RandomNumberGenerator.new() #random number generator

# point 1
func _physics_process(delta): # used to know what the current gun is
	match gun_id:
		1:
			current_loaded = pistol_loaded
		2:
			current_loaded = rifle_loaded
		3:
			current_loaded = shotgun_loaded
		4:
			current_loaded = awp_loaded

func shoot_1(): # shoots single bullets without bullet spread
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	new_bullet.load_gun(bullet_speed, bullet_range)
	if trail_enabled:
		var bullet_trail = BULLET_TRAIL.instantiate()
		new_bullet.add_child(bullet_trail)
		bullet_trail.global_position = new_bullet.global_position
		bullet_trail.global_rotation = new_bullet.global_rotation
	%ShootingPoint.add_child(new_bullet)
func shoot_2(): # shoots multiple bullets without bullet spread
	var angle_increment = deg_to_rad(spray_angle / (bullet_count - 1))  # Angle increment in radians
	var start_angle = -deg_to_rad(spray_angle / 2)
	for i in range(0, bullet_count, 1):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation + start_angle + (i * angle_increment)
		new_bullet.load_gun(bullet_speed, bullet_range)
		if trail_enabled:
			var bullet_trail = BULLET_TRAIL.instantiate()
			new_bullet.add_child(bullet_trail)
			bullet_trail.global_position = new_bullet.global_position
			bullet_trail.global_rotation = new_bullet.global_rotation
		%ShootingPoint.add_child(new_bullet)
func shoot_3(): #shoots single bullets with bullet spread
	var start_angle = -deg_to_rad(spray_angle / 2)
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation + start_angle + deg_to_rad(float((randi() % int(spray_angle*200))/200))
	new_bullet.load_gun(bullet_speed, bullet_range)	
	if trail_enabled:
		var bullet_trail = BULLET_TRAIL.instantiate()
		new_bullet.add_child(bullet_trail)
		bullet_trail.global_position = new_bullet.global_position
		bullet_trail.global_rotation = new_bullet.global_rotation
	%ShootingPoint.add_child(new_bullet)
func shoot_4(): #shoots multiple bullets without bullet spread
	var angle_increment = deg_to_rad(spray_angle / (bullet_count - 1))  # Angle increment in radians
	var start_angle = -deg_to_rad(spray_angle / 2)
	for i in range(0,bullet_count,1):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation + start_angle + deg_to_rad(float((randi() % int(spray_angle*200))/200))
		new_bullet.load_gun(bullet_speed, bullet_range+randi()%30)
		if trail_enabled:
			var bullet_trail = BULLET_TRAIL.instantiate()
			new_bullet.add_child(bullet_trail)
			bullet_trail.global_position = new_bullet.global_position
			bullet_trail.global_rotation = new_bullet.global_rotation
		%ShootingPoint.add_child(new_bullet)

# autoshoot 
func _on_timer_timeout():
	if current_loaded:
		#no spread
		if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and auto_fire and not bullet_spread):
			match gun_type:
				1:
					shoot_1()
				2:
					shoot_2()
				_:
					pass
			loaded_checker()
		#spread
		elif (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and auto_fire and bullet_spread):
			match gun_type:
				1:
					shoot_3()
				2:
					shoot_4()
				_:
					pass
			loaded_checker()
	else:
		pass

# click to shoot
func _input(event):
	if current_loaded:
		#no spread
		if event.is_action_pressed("click") and !auto_fire and not bullet_spread:
			emit_signal("manual_shot")
			match gun_type:
				1:
					shoot_1()
				2:
					shoot_2()
				_:
					pass
			loaded_checker()
		#spread
		if event.is_action_pressed("click") and !auto_fire and bullet_spread:
			emit_signal("manual_shot")
			match gun_type:
				1:
					shoot_3()
				2:
					shoot_4()
				_:
					pass
			loaded_checker()

# point 2
static var pistol_loaded: bool = true #used for non-autofire
func _on_pistol():
	gun_id = 1 #gun's unique id
	gun_type = 1 #1=one bullet 2=multiple bullets
	auto_fire = false #self explanatory
	bullet_spread = true #is there bullet spread?
	bullet_count = 1 #bullets per shot (only for guntype 2)
	spray_angle = 2.00 #DO NOT SET TO 0 UNLESS bullet_spread = false(only for guntype 2)
	bullet_speed = 1000 #self explanatory
	bullet_range = 10000 #distance bullets travel
	reload_time = 0.2 #min time between shots
	trail_enabled = true #determines if bullets have a trail or not
static var rifle_loaded: bool = true #used for non-autofire
func _on_rifle():
	gun_id = 2 #gun's unique id
	gun_type = 1 #1=one bullet 2=multiple bullets
	auto_fire = true #self explanatory
	bullet_spread = true #is there bullet spread?
	bullet_count = 1 #bullets per shot (only for guntype 2)
	spray_angle = 10.00 #DO NOT SET TO 0 UNLESS bullet_spread = false(only for guntype 2)
	bullet_speed = 1000 #self explanatory
	bullet_range = 10000 #distance bullets travel
	reload_time = 0.05 #min time between shots
	trail_enabled = true #determines if bullets have a trail or not
static var shotgun_loaded: bool = true #used for non-autofire
func _on_shotgun():
	gun_id = 3 #gun's unique id
	gun_type = 2 #1=one bullet 2=multiple bullets
	auto_fire = false #self explanatory
	bullet_spread = true #is there bullet spread?
	bullet_count = 12 #bullets per shot (only for guntype 2)
	spray_angle = 40 #DO NOT SET TO 0 UNLESS bullet_spread = false(only for guntype 2)
	bullet_speed = 1500 #self explanatory
	bullet_range = 300 #distance bullets travel
	reload_time = 0.50 #min time between shots
	trail_enabled = true #determines if bullets have a trail or not
static var awp_loaded: bool = true #used for non-autofire
func _on_awp():
	gun_id = 4 #gun's unique id
	gun_type = 1 #1=one bullet 2=multiple bullets
	auto_fire = false #self explanatory
	bullet_spread = false #is there bullet spread?
	bullet_count = 1 #bullets per shot (only for guntype 2)
	spray_angle = 0.0 #DO NOT SET TO 0 UNLESS bullet_spread = false(only for guntype 2)
	bullet_speed = 1000 #self explanatory
	bullet_range = 10000 #distance bullets travel
	reload_time = 2.0 #min time between shots
	trail_enabled = true #determines if bullets have a trail or not

# point 3
func _process(delta):
	if Input.is_action_pressed("1"): #pistol
		emit_signal("pistol")
	if Input.is_action_pressed("2"): #rifle
		emit_signal("rifle")
	if Input.is_action_pressed("3"): #shotgun
		emit_signal("shotgun")
	if Input.is_action_pressed("4"): #awp
		emit_signal("awp")

#point 4
func loaded_checker():
	current_loaded = false
	match gun_id:
		1:
			pistol_loaded = false
			await get_tree().create_timer(reload_time).timeout
			pistol_loaded = true
		2:
			rifle_loaded = false
			await get_tree().create_timer(reload_time).timeout
			rifle_loaded = true
		3:
			shotgun_loaded = false
			await get_tree().create_timer(reload_time).timeout
			shotgun_loaded = true
		4:
			awp_loaded = false
			await get_tree().create_timer(reload_time).timeout
			awp_loaded = true
	current_loaded = true

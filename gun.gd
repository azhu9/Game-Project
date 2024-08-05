extends Area2D

const BULLET = preload("res://bullet.tscn")

func shoot_1():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
func shoot_2():
	var bullet_count = 25
	var spray_angle = 30  # Total spray angle in degrees
	var angle_increment = deg_to_rad(spray_angle / (bullet_count - 1))  # Angle increment in radians
	var start_angle = -deg_to_rad(spray_angle / 2)

	for i in range(0,bullet_count,1):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation + start_angle + (i*angle_increment)
		new_bullet.load_gun(1000, 10000)
		%ShootingPoint.add_child(new_bullet)
	
""" 
##alternate shooting method- click to shoot 1 bullet
func _input(event):
	if event.is_action_pressed("click"):
		shoot()
"""

static var gun: int = 2

static var gun_id: int = 2:
	get:
		return gun_id
	set(value):
		gun_id = value


func _on_timer_timeout():
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		match gun_id:
			1:
				shoot_1()
			2:
				shoot_2()
			_:
				pass
	

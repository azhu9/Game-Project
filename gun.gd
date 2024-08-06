extends Area2D
signal manual_shot

const BULLET = preload("res://bullet.tscn")

func shoot_1():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	new_bullet.load_gun(1500, 1000)
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
		new_bullet.load_gun(1500, 100)
		%ShootingPoint.add_child(new_bullet)
	
""" 
##alternate shooting method- click to shoot 1 bullet
func _input(event):
	if event.is_action_pressed("click"):
		shoot()
"""

static var gun_id: int = 1
var auto_fire: bool = false


func _on_timer_timeout():
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and auto_fire):
		match gun_id:
			1:
				shoot_1()
			2:
				shoot_2()
			_:
				pass
	
func _input(event):
	if event.is_action_pressed("click") and !auto_fire:
		rotate(get_angle_to(get_global_mouse_position()))
		emit_signal("manual_shot")
		shoot_1()

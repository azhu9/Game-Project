extends Area2D

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	

func _input(event):
	if event.is_action_pressed("click"):
		await get_tree().create_timer(0.1).timeout
		shoot()

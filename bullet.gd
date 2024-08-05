extends Area2D

var distance_travelled = 0
var speed
var range

func load_gun(s, r):
	speed = s
	range = r

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	distance_travelled += speed * delta
	if distance_travelled > range:
		queue_free()

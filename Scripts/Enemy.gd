extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var ai = $AI

var health: int = 100

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 50.0
	move_and_slide()
		

func handle_hit():
	health -= 20
	if(health <= 0):
		queue_free()

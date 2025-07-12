extends CharacterBody2D

@export var speed = 100.0
@onready var animated = $AnimatedSprite2D

func _physics_process(delta):
	$AnimatedSprite2D.z_index = int(global_position.y)
	move_player()
	move_and_slide()

func move_player():
	var input_x = Input.get_axis("ui_left", "ui_right")
	var input_y = Input.get_axis("ui_up", "ui_down")
	
	if input_y < 0:
		animated.play("walk_up")
	elif input_y > 0:
		animated.play("walk_down")
	elif input_x < 0:
		animated.play("walk_left")
	elif input_x > 0:
		animated.play("walk_right")
	else:
		animated.play("idle")
	
	velocity.x = input_x * speed
	velocity.y = input_y * speed

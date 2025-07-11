extends CharacterBody2D

@export var speed = 100.0
@onready var animated = $AnimatedSprite2D

func _physics_process(delta):
	move_player()
	move_and_slide()

func move_player():
	var input_x = Input.get_axis("ui_left", "ui_right")
	var input_y = Input.get_axis("ui_up", "ui_down")
	
	if input_y < 0:
		animated.play("walk_up")
	if input_y > 0:
		animated.play("walk_down")
		
	if input_x < 0:
		animated.play("walk_left")
	if input_x > 0:
		animated.play("walk_right")
	
	if input_x == 0 and input_y == 0:
		animated.play("idle")
	
	velocity.y = input_y * speed
	velocity.x = input_x * speed

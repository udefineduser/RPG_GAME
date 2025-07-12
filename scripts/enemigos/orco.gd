extends CharacterBody2D

@export var velocidad := 80.0
@export var rango_deteccion := 100.0
@export var fuerza_repulsion := 80.0 

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var radar := $Radar
@onready var colisionador := $CollisionShape2D 

var jugador: Node2D = null
var persiguiendo := false

func _ready():
	radar.body_entered.connect(_on_radar_body_entered)
	radar.body_exited.connect(_on_radar_body_exited)

func _physics_process(delta):
	if persiguiendo and jugador:
		var direccion = (jugador.position - position).normalized()
		
		if test_move(transform, direccion * velocidad * delta):
			velocity = -direccion * fuerza_repulsion
		else:
			velocity = direccion * velocidad
			
		move_and_slide()
		actualizar_animacion(direccion)

func actualizar_animacion(direccion: Vector2):
	if velocity.length() > 10:
		if abs(direccion.x) > abs(direccion.y):
			anim.flip_h = direccion.x < 0
			anim.play("run_derecha")
		else:
			anim.play("run_abajo" if direccion.y > 0 else "run_arriba")
	else:
		anim.play("idle_abajo")

func _on_radar_body_entered(body: Node2D):
	if body.is_in_group("player"):
		jugador = body
		persiguiendo = true

func _on_radar_body_exited(body: Node2D):
	if body == jugador:
		persiguiendo = false
		jugador = null
		anim.play("idle_abajo")
		velocity = Vector2.ZERO

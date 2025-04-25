extends CharacterBody2D

@export var speed = 400               # Velocidad de movimiento horizontal
@export var gravedad = 981            # Fuerza de gravedad (como en la vida real)
@export var salto_fuerza = 400       # Fuerza hacia arriba al saltar (negativa porque y aumenta hacia abajo)
@export var saltosMaximos = 2

var cantidadSaltos =0;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direccion = Vector2.ZERO        # Creamos un vector de dirección

	# Movimiento lateral
	if Input.is_action_pressed("Right"): # si apreta la tecla asociada con "Right"
		direccion.x += 1 #Direccion en el eje x aumenta 1 (1,0)
		$AnimatedSprite2D.flip_h = false # la animacion no se voltea en el eje horizontal
	elif Input.is_action_pressed("Left"): # si preciona la tecla asociada con "Left"
		direccion.x -= 1 #Direccion en el eje x disminuye 1 (-1,0)
		$AnimatedSprite2D.flip_h = true # la animacion si se voltea en el eje horizontal 

	# Aplicar movimiento horizontal a la velocidad
	velocity.x = direccion.x * speed

	# Aplicar gravedad (sólo hacia abajo)
	velocity.y += gravedad * delta

	# Salto
	if cantidadSaltos < saltosMaximos and Input.is_action_just_pressed("Space"): # si esta tocando el suelo y precionando la tecla asociada a "Space"
		velocity.y -= salto_fuerza # 
		cantidadSaltos += 1
	
	if is_on_floor(): 
		cantidadSaltos= 0

	# Animación
	if direccion.x != 0:
		$AnimatedSprite2D.play("Caminata")
	else:
		$AnimatedSprite2D.stop()

	# Mover al personaje con detección de colisiones
	move_and_slide()

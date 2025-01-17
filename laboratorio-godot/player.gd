extends CharacterBody2D


const SPEED =  200.0
const JUMP_VELOCITY = -100.0

func _physics_process(delta: float) -> void:
	
	var direction  = Input.get_vector("move_esquerda", "move_direita", "move_cima", "move_baixo")
	
	if Input.is_action_pressed("move_esquerda") || Input.is_action_pressed("move_direita"):
		direction.y  = 0
	elif Input.is_action_pressed("move_cima") || Input.is_action_pressed("move_baixo"):
		direction.x = 0
	else:
		direction = Vector2.ZERO
		$AnimatedSprite2D.play("parado")
		
	direction = direction.normalized() 	
	velocity = (direction * SPEED)
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite2D.play("andando_tras")
	if Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite2D.play("andando_frente")
	
			
		

extends CharacterBody2D


const SPEED =  200.0
const JUMP_VELOCITY = -100.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var last_direction = "parado_baixo"

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("action_speak"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return 
		#DialogueManager.show_example_dialogue_balloon (load("res://dialogue/main.dialogue"), "start")
		#return 
		
	
	var direction  = Input.get_vector("move_esquerda", "move_direita", "move_cima", "move_baixo")
	
	if Input.is_action_pressed("move_esquerda") || Input.is_action_pressed("move_direita"):
		direction.y  = 0
	elif Input.is_action_pressed("move_cima") || Input.is_action_pressed("move_baixo"):
		direction.x = 0
	else:
		direction = Vector2.ZERO
		$AnimatedSprite2D.play(last_direction)
		
	direction = direction.normalized() 	
	velocity = (direction * SPEED)
	move_and_slide()
	
	if Input.is_action_pressed("move_esquerda"):
		$AnimatedSprite2D.play("andando_tras")
		last_direction = "parado_esquerda"
		
	elif Input.is_action_pressed("move_direita"):
		$AnimatedSprite2D.play("andando_frente")
		last_direction = "parado_direita"
		
	elif Input.is_action_pressed("move_cima"):
		$AnimatedSprite2D.play("andando_cima")	
		last_direction = "parado_cima"
		
	elif Input.is_action_pressed("move_baixo"):
		$AnimatedSprite2D.play("andando_baixo")		
		last_direction = "parado_baixo"	
			
		

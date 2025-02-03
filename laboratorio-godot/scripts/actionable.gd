extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var isChallenge: bool

@onready var cena: PackedScene = preload ("res://scenes/challenge.tscn")

func action() -> void:
	if isChallenge:
		print("Vamos ao desafio!")
		get_tree().change_scene_to_packed(cena)
	else:
		
		DialogueManager.show_dialogue_balloon_scene("res://dialogue/balloon.tscn", dialogue_resource, dialogue_start)
	
	# func show_dialogue_balloon_scene(balloon_scene, resource: DialogueResource, title: String = "", extra_game_states: Array = []) -> Node:

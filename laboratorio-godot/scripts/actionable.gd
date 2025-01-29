extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action() -> void:
	DialogueManager.show_dialogue_balloon_scene("res://dialogue/balloon.tscn", dialogue_resource, dialogue_start)
	
	# func show_dialogue_balloon_scene(balloon_scene, resource: DialogueResource, title: String = "", extra_game_states: Array = []) -> Node:

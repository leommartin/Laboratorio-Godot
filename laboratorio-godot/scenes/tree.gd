extends StaticBody2D

@onready var interaction_area = $"../Tree/Actionable"
@onready var ui_challenge = $"../CanvasLayer/Challenge"
var player_in_area = false

func _ready():
	ui_challenge.visible = false  # Esconde o painel no início
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)

func _input(event):
	if event.is_action_pressed("interact") and player_in_area:
		ui_challenge.visible = true  # Exibe o painel do desafio

func _on_body_entered(body):
	if body.is_in_group("player"):  # Certifique-se que o player está no grupo correto
		player_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false

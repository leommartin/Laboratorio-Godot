extends Node2D

@onready var hint_button = $"../Button"

func _draw():
	
	var pos = hint_button.position + Vector2(hint_button.size.x, 0)  # Soma apenas no eixo X
	var rad = 11
	var col = Color(1, 0, 0, 1)  # Certifique-se que o alpha está 1 para ser visível
	draw_circle(pos, rad, col)

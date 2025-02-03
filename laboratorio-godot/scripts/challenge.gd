extends Control

@onready var dialog_balloon = $ChallengeBalloon
@onready var hint_button = $Button
@onready var timer: Timer = $HintTimer  # Timer adicionado à cena

var dialogue_resource: DialogueResource
var dialogue_start: String
var dica_numero = 1
var cooldown_time = 5.0  # Tempo de espera em segundos

func _ready():
	hint_button.pressed.connect(_on_button_pressed)
	
	# Configura o Timer
	timer.wait_time = cooldown_time
	timer.one_shot = true  # Para rodar apenas uma vez
	timer.timeout.connect(_on_timer_timeout)

func _on_button_pressed() -> void:
	if not timer.is_stopped():  # Se o Timer ainda estiver rodando, não faz nada
		return

	hint_button.disabled = true  # Desativa o botão temporariamente
	timer.start()  # Inicia o cooldown

	dialogue_resource = load("res://dialogue/dicas.dialogue") as DialogueResource
	
	if dica_numero > 3:
		dica_numero = 1
		 
	dialogue_start = "dica" + str(dica_numero) if dica_numero != 0 else "start"
	
	dica_numero += 1
	
	if dialogue_resource:
		DialogueManager.show_dialogue_balloon_scene("res://challenge_balloon.tscn", dialogue_resource, dialogue_start)
	else:
		print("Erro: Não foi possível carregar o diálogo 'dicas.dialogue'!")

func _on_timer_timeout():
	hint_button.disabled = false  # Reativa o botão após o cooldown

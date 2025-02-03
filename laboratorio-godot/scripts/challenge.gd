extends Control

@onready var dialog_balloon = $ChallengeBalloon
@onready var hint_button = $Button
@onready var timer: Timer = $HintTimer  # Timer para cooldown

var dialogue_resource: DialogueResource
var dialogue_start: String
var dica_numero = 1
var cooldown_time = 10.0  # Tempo de espera em segundos
var original_hint_text: String  # Armazena o texto original do botão

func _ready():
	hint_button.pressed.connect(_on_button_pressed)
	
	# Configura o Timer
	timer.wait_time = 1.0  # Atualiza a cada segundo
	timer.one_shot = false  # Permite rodar continuamente até o tempo acabar
	timer.timeout.connect(_update_countdown)

	# Armazena o texto original do botão
	original_hint_text = hint_button.text  

func _on_button_pressed() -> void:
	if not timer.is_stopped():  # Se o Timer ainda estiver rodando, não faz nada
		return

	hint_button.disabled = true  # Desativa o botão temporariamente
	timer.start()  # Inicia o timer para atualização da contagem regressiva

	# Define o tempo total de cooldown
	timer.set_meta("remaining_time", cooldown_time)
	_update_countdown()  # Atualiza o botão imediatamente

	dialogue_resource = load("res://dialogue/dicas.dialogue") as DialogueResource
	
	if dica_numero > 3:
		dica_numero = 1
		 
	dialogue_start = "dica" + str(dica_numero) if dica_numero != 0 else "start"
	
	dica_numero += 1
	
	if dialogue_resource:
		DialogueManager.show_dialogue_balloon_scene("res://challenge_balloon.tscn", dialogue_resource, dialogue_start)
	else:
		print("Erro: Não foi possível carregar o diálogo 'dicas.dialogue'!")

func _update_countdown():
	var remaining_time = timer.get_meta("remaining_time") as float
	remaining_time -= 1
	timer.set_meta("remaining_time", remaining_time)

	if remaining_time > 0:
		hint_button.text = str(int(remaining_time)) + "s"
	else:
		_on_timer_timeout()  # Finaliza o cooldown

func _on_timer_timeout():
	timer.stop()
	hint_button.disabled = false  # Reativa o botão após o cooldown
	hint_button.text = original_hint_text  # Restaura o texto original ("Dicas")

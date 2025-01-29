extends Control  # Ou o nó ao qual o botão pertence

@onready var dialog = $ChallengeBalloon  # Referência à cena do diálogo
@onready var hint_button = $HintButton    # Referência ao botão de dicas

func _ready():
	hint_button.pressed.connect(_on_hint_button_pressed)

func _on_hint_button_pressed():
	dialog.visible = true  # Torna o diálogo visível

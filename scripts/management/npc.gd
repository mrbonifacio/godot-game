extends StaticBody2D
class_name Npc

onready var quest_mark: Sprite = get_node("QuestMark")

var can_interact: bool = false
var is_quest_finished: bool = false 
var is_dialog_displayed: bool = false  # Adicione essa variável
var is_dialog_active: bool = false  # Adicione essa variável

var player_ref: KinematicBody2D = null

export(Array, String) var dialog_text
export(Array, String) var special_text 

func _ready() -> void:
	Global.enemies_dict[3] = self 
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_interact") and can_interact and not is_dialog_active:
		can_interact = false
		player_ref.freeze(false)
		is_dialog_active = true  # Diálogo está ativo, evita repetição
		
		if is_quest_finished:
			get_tree().call_group("interface", "spawn_dialog", self, special_text)
		else:
			get_tree().call_group("interface", "spawn_dialog", self, dialog_text)
	
	if is_dialog_active and not is_dialog_displayed:
		is_dialog_displayed = true
		# Iniciar o diálogo aqui (exibir a caixa de diálogo na tela)
	
func _on_body_entered(body) -> void:
	if body is Player:
		player_ref = body
		can_interact = true
		quest_mark.visible = true

func _on_body_exited(body) -> void:
	if body is Player:
		player_ref = null
		can_interact = false
		quest_mark.visible = false

func on_dialog_finished() -> void: 
	can_interact = true
	player_ref.freeze(true)
	is_dialog_active = false
	is_dialog_displayed = false

extends CanvasLayer
class_name Interface

const DIALOG: PackedScene = preload("res://Scenes/management/dialog.tscn")

func spawn_dialog(npc, dialog_text_list: Array) -> void: 
	var dialog: Dialog = DIALOG.instance()
	dialog.dialog_text_list = dialog_text_list
	var _dialog: bool = dialog.connect("dialog_finished", npc, "on_dialog_finished")
	
	# Verifique se há algum diálogo sendo exibido, remova-o antes de adicionar um novo
	if get_child_count() > 0:
		var existing_dialog = get_child(0)
		existing_dialog.queue_free()  # Remove o diálogo existente
	
	add_child(dialog)

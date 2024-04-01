extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $Container/VBoxContainer2/Username/LineEdit
onready var password : LineEdit = $Container/VBoxContainer2/Password/LineEdit
onready var notification : Label = $Container/Notification

func _on_LoginButton_pressed():
	if username.text.empty() or password.text.empty():
		notification.text = "Please, enter your username and password"
		return
	Firebase.login(username.text, password.text, http)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
	else:
		notification.text = "Sign in succesful!"
		get_tree().change_scene("res://Scenes/management/game_level.tscn")

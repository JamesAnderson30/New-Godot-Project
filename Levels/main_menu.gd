extends Control

signal start_game
# defining a signal for Main.


func _on_start_pressed():
	emit_signal("start_game") # will send this back to main, right?
	

func _on_settings_pressed():
	pass # no settings functios yet, so..

func _on_quit_pressed():
	get_tree() .quit() 

extends Control



func _on_start_pressed():
	get_tree() .change_scene_to_file("res://main.tscn") # may have to replace w/ save data thing for future.

func _on_settings_pressed():
	pass # no settings functios yet, so..

func _on_quit_pressed():
	get_tree() .quit() 

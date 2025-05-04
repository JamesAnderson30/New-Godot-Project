extends Node

var playerScene = preload("res://Actors/Player/PlayerHandler.tscn")

func loadPlayer():
	return playerScene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

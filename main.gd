extends Node3D
#Preload External Scenes that the main program needs to call on
var actor = preload("res://Actor.tscn")

var Actor = actor.instantiate()

func _ready():
	var testEnemy = Actor.createEnemy("Test Foe")
	add_child(testEnemy)

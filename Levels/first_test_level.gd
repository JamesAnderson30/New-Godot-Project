extends Node3D

var EnemyHandler = preload("res://Actors/Enemies/EnemyList/TestFoe.tscn")
var enemyHandler = EnemyHandler.instantiate()
var PlayerHandler = preload("res://Actors/Player/PlayerHandler.tscn")
var playerHandler = PlayerHandler.instantiate()



var initialSpawn = [
	{"id": "Test Foe", "position": Vector3(1, 1, 1)},
	{"id": "Test Foe", "position": Vector3(2, 2, 0.5)},
	{"id": "Test Foe", "position": Vector3(1.5, 1.5, 2.5)}
]

func spawnThing(scene):
	add_child(scene)

func _ready():
	pass

	

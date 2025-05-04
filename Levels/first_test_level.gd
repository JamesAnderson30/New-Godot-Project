extends Node3D

var EnemyHandler = load("res://Actors/Enemies/TestFoe.tscn")
var PlayerHandler = load("res://Actors/Player/PlayerHandler.tscn")

var initialSpawn = [
	{"id": "Test Foe", "position": Vector3(10, 10, 10)},
	{"id": "Test Foe", "position": Vector3(20, 20, 5)},
	{"id": "Test Foe", "position": Vector3(15, 15, 25)}
]

func _ready():
	print("Level ready - spawning things..")
	
	for spawn in initialSpawn:
		var enemy = EnemyHandler.createEnemy(spawn["id"])
		if enemy:
			enemy.position = spawn["position"]
			add_child(enemy)
	#spawn player here..
	var player = PlayerHandler.loadPlayer()
	player.position = Vector3(0, 5, 0)
	add_child(player)
	

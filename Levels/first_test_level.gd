extends Node3D

var EnemyHandler = preload("res://Actors/Enemies/TestFoe.tscn")
var enemyHandler = EnemyHandler.instantiate()
var PlayerHandler = preload("res://Actors/Player/PlayerHandler.tscn")
var playerHandler = PlayerHandler.instantiate()



var initialSpawn = [
	{"id": "Test Foe", "position": Vector3(1, 1, 1)},
	{"id": "Test Foe", "position": Vector3(2, 2, 0.5)},
	{"id": "Test Foe", "position": Vector3(1.5, 1.5, 2.5)}
]

func _ready():
	print("Level ready - spawning things..")
	
	for spawn in initialSpawn:
		var enemy = enemyHandler.createEnemy(spawn["id"])
		if enemy:
			enemy.position = spawn["position"]
			print(enemy)
			add_child(enemy)
	#spawn player here..
	var player = playerHandler.loadPlayer()
	player.position = Vector3(0, 5, 0)
	add_child(player)
	

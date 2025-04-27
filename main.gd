extends Node3D
#Preload External Handlers that the main program needs to call on
var ActorHandler = preload("res://Actor.tscn")
var LevelHandler = preload("res://LevelHandler.tscn")
var PlayerHandler = preload("res://Player/PlayerHandler.tscn")

var actorHandler = ActorHandler.instantiate()
var levelHandler = LevelHandler.instantiate()
var playerHandler = PlayerHandler.instantiate()

func _ready():
	var testLevel = levelHandler.loadLevel()
	var player = playerHandler.loadPlayer()
	var testEnemy = actorHandler.createEnemy("Test Foe")
	print(player)
	add_child(testLevel)
	add_child(player)
	add_child(testEnemy)

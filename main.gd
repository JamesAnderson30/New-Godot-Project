extends Node3D
#Preload External Handlers that the main program needs to call on

var ActorHandler = preload("res://Actor.tscn")
var LevelHandler = preload("res://LevelHandler.tscn")
var PlayerHandler = preload("res://Player/PlayerHandler.tscn")


var actorHandler = ActorHandler.instantiate()
var levelHandler = LevelHandler.instantiate()
var playerHandler = PlayerHandler.instantiate()

func _ready():
	var menuStart = levelHandler.loadLevel("mainMenu")
	add_child(menuStart)
	
	# Signal connection..
	menuStart.connect("start_game", self._on_main_menu_start_game)
	# I couldn't get this part to work by passing the _on_main_menu_start_game as a string..
	
func _on_main_menu_start_game():
	print("Start recieved..")
	
	# this bit clears up the main menu so it doesn't display over the loaded level..
	for child in get_children():
		child.queue_free()
	
	# Presumably we can make similar functions for loading new levels ya?
	var testEnemy = actorHandler.createEnemy("Test Foe")
	var testLevel = levelHandler.loadLevel("firstLevel")
	var player = playerHandler.loadPlayer()
	
	add_child(testLevel)
	add_child(player)
	add_child(testEnemy)

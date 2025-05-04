extends Node3D
signal start_level_one
#Preload External Handlers that the main program needs to call on
var LevelHandler = preload("res://Levels/LevelHandler.tscn")
var levelHandler = LevelHandler.instantiate()

func _ready():
	var menuStart = levelHandler.loadLevel("mainMenu")
	add_child(menuStart)
	
	# Signal connection..
	menuStart.connect("start_game", self._on_main_menu_start_game)
	connect("start_level_one", Callable(levelHandler, "firstStart"))
	# I couldn't get this part to work by passing the _on_main_menu_start_game as a string..
	
func _on_main_menu_start_game():
	print("Start recieved..")
	for child in get_children():
		child.queue_free()
	print(levelHandler.loadLevel("firstLevel"))
	add_child(levelHandler.loadLevel("firstLevel"))
	
	# this bit clears up the main menu so it doesn't display over the loaded level..
	
		
	
	# Presumably we can make similar functions for loading new levels ya?
	#var testEnemy = actorHandler.createEnemy("Test Foe")
	#var testLevel = levelHandler.loadLevel("firstLevel")
	#var player = playerHandler.loadPlayer()
	
	#add_child(testLevel)
	#add_child(player)
	#add_child(testEnemy)

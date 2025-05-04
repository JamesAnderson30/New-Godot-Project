extends Node


# Called when the node enters the Handler tree for the first time.
func _ready():
	connect("start_level_one", self.firstStart)
	
#var currentLevelNumber = 0

var level_list = [
	# adding main menu to list, and defining "id" to use.
	{
		"id": "mainMenu",
		"name": "Main Menu",
		"scene": preload("res://Menus/MainMenu/MainMenu.tscn")
	},
	
	{
		"id": "firstLevel",
		"name": "First Test Level",
		"scene": preload("res://Levels/FirstTestLevel.tscn")
	}
]

# this function will need to be updated?
#func loadLevelByNumber(levelNum):
	#if(levelNum >= 0 && levelNum < level_list.size() - 1):
		#var newLevel = level_list[levelNum]["Handler"].instantiate()
		#return newLevel

func firstStart():
	print("Level Handler recieved signal")
	loadLevel("firstLevel")
	

func loadLevel(level_id):
	print(level_list.size(), " Load Level received call..")
	# prints 2 as of writing, correct.
	for level in level_list:
		if level["id"] == level_id:
			var scene = level["scene"].instantiate()
			return scene
	push_error("loadLevel ERROR: Level ID not found in level_list", % level_id)
	#return "Cannot generate"





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass

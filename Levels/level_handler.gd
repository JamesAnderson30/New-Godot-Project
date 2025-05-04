extends Node
var EnemyHandler = preload("res://Actors/Enemies/EnemyHandler.tscn")
var enemyHandler = EnemyHandler.instantiate()
var PlayerHandler = preload("res://Actors/Player/PlayerHandler.tscn")
var playerHandler = PlayerHandler.instantiate()

# Called when the node enters the Handler tree for the first time.
func _ready():
	connect("start_level_one", self.firstStart)
	
#var currentLevelNumber = 0

var level_list = {
	# adding main menu to list, and defining "id" to use.
	"mainMenu" : {
		"name": "Main Menu",
		"scene": preload("res://Menus/MainMenu/MainMenu.tscn")
	},
	"firstLevel" : {
		"name": "First Test Level",
		"scene": preload("res://Levels/FirstTestLevel.tscn")
	}
}

# this function will need to be updated?
#func loadLevelByNumber(levelNum):
	#if(levelNum >= 0 && levelNum < level_list.size() - 1):
		#var newLevel = level_list[levelNum]["Handler"].instantiate()
		#return newLevel

func firstStart():
	print("Level Handler recieved signal")
	loadLevel("firstLevel")
	

func loadLevel(level_id):
	print("Loading Level...")
	# LOAD LEVEL SCENE
	var levelScene = level_list[level_id]["scene"].instantiate()
	
	print("Level Loaded: ", levelScene)
	print("Spawning Things...")
	
	if("spawnThing" in levelScene):
		for spawn in levelScene.initialSpawn:
			var enemy = enemyHandler.createEnemy(spawn["id"])
			if enemy:
				enemy.position = spawn["position"]
				print(enemy)
				levelScene.spawnThing(enemy)

	#spawn player here..
	print("Spawning Player...")
	if("spawnThing" in levelScene):
		var player = playerHandler.loadPlayer()
		player.position = Vector3(0, 5, 0)
		levelScene.spawnThing(player)
	
	return levelScene
	push_error("loadLevel ERROR: Level ID not found in level_list", % level_id)
	#return "Cannot generate"





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass

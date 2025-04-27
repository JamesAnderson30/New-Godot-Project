extends Node

var currentLevelNumber = 0

var level_list = [
	{
		"name": "First Test Level",
		"Handler": preload("res://Levels/FirstTestLevel.tscn")
	}
]

func loadLevelByNumber(levelNum):
	if(levelNum >= 0 && levelNum < level_list.size() - 1):
		var newLevel = level_list[levelNum]["Handler"].instantiate()
		return newLevel


func loadLevel():
	print(level_list.size())
	if(currentLevelNumber >= 0 && currentLevelNumber < level_list.size()):
		var newLevel = level_list[currentLevelNumber]["Handler"].instantiate()
		return newLevel
	else:
		print("Level Number out of bounds")


# Called when the node enters the Handler tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

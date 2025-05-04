extends Node3D
class_name BasicEnemyScript

# Called when the node enters the scene tree for the first time.
# BASIC ENEMY PARAMETERS
var hp = 100
var statusEffects = []
var walkingSpeed = 1
var runningSpeed = 2
# END ENEMY PARAMETERS


func test():
	print("You did it bendy")

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

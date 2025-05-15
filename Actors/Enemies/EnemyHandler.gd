extends CharacterBody3D
class_name EnemyHandler

var navTarget = null
var hp = 100
var gravity = 9.8


func setNavigationTarget(newTarget: Node):
	navTarget = newTarget
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	We need to set velocity to zero
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

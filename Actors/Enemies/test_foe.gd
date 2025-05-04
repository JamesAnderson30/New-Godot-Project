extends Node3D

var enemyList = {
	"Test Foe": preload("res://Actors/Enemies/TestFoe.tscn")
}


func createEnemy(enemyName, x_position = 0, y_position = 0, z_position = 0):
	if enemyName in enemyList:
		var newEnemy = enemyList[enemyName].instantiate()
		newEnemy.position = Vector3(x_position, y_position, z_position)
		return newEnemy

# Called when the node enters the Handler tree for the first time.
func _ready() -> void:
	$MeshInstance3D.mesh.material.albedo_color = Color(0, 0, 1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

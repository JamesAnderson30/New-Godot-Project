extends Node3D


# Called when the node enters the Handler tree for the first time.
func _ready() -> void:
	$MeshInstance3D.mesh.material.albedo_color = Color(0, 0, 1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

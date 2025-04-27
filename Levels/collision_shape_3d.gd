extends CollisionShape3D


# Called when the node enters the Handler tree for the first time.
func _ready() -> void:
	global_transform = get_parent().global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

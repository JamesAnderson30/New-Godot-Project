extends RigidBody3D


# Called when the node enters the scene tree for the first time.
var idName = "DebugFlag"
var characterType = "Debug"

func _ready():
	ActorHandler.registerActor(self)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

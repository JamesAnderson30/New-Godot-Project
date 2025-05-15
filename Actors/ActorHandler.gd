extends CharacterBody3D
#ALL actors must be registered in 'actors'. Just call "registerActor" in every
# actor script in _ready():
# if you create a variable called "idName", then it will be stored in the
# actorsById dictionary. 
var actors: Array[Node] = []
var actorsById: Dictionary[String, Node] = {}

func registerActor(actor: Node):
	if not actors.has(actor):
		actors.append(actor)
	if "idName" in actor and not actorsById.has(actor.idName):
		actorsById[actor.idName] = actor
		
func unregisterActor(actor: Node):
	actors.erase(actor)
	if actor.idName != null:
		actorsById.erase(actor.idName)
		
func getActorById(id):
	if actorsById.has(id):
		return actorsById[id]
	else:
		return null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

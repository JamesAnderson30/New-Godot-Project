extends EnemyHandler
@onready var navAgent = $NavigationAgent3D

# STATE
var Idle_State = preload("States/Idle_state.gd")
var In_Air_State = preload("States/In_Air_State.gd")
var Chase_Target_State = preload("States/Chase_Target_State.gd")
 
var currentState = Idle_State.new()

var walkingSpeed = 1

# STATE
func changeState(newStateName):
	if newStateName != currentState.stateName:
		match newStateName:
			"idle": 
				currentState = Idle_State.new()
			"in_air":
				currentState = In_Air_State.new()
			"chase_target":
				currentState = Chase_Target_State.new()
				
		add_child(currentState)
		currentState.enter()

# Called when the node enters the Handler tree for the first time.
func _ready() -> void:
	changeState("idle")
#	REGISTER ACTOR
	ActorHandler.registerActor(self)
#	SET UP ENEMY PARAMETERS
	hp = 150
	
	setNavigationTarget(ActorHandler.getActorById("Player"))


#	SET VISUAL ATTRIBUTES
	$MeshInstance3D.mesh.material.albedo_color = Color(0, 0, 1, 1)
	
#	SET ENEMY TARGET
	#setNavigationTarget()

func _physics_process(delta):

#	Gravity
	if not is_on_floor():
		changeState("in_air")
		velocity.y -= gravity * delta #This makes the actor falls
	else:
		if navTarget != null:
			changeState("chase_target")
		else:
			changeState("idle")
		velocity.y = 0
	move_and_slide()
		
	if currentState.stateName == "chase_target":
		if(navTarget == null):
			return
			
		navAgent.target_position = navTarget.global_position
		
		if(navAgent.is_navigation_finished()):
			return
			
		var next_position = navAgent.get_next_path_position()
		var direction = (next_position - global_position).normalized()
		velocity = direction * walkingSpeed
		move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if(navTarget == null):
		#return
		#
	#navAgent.target_position = navTarget.global_position
	#
	#if(navAgent.is_navigation_finished()):
		#return
		#
	#var next_position = navAgent.get_next_path_position()
	#var direction = (next_position - global_position).normalized()
	#var velocity = direction * walkingSpeed
	#move_and_slide()
	pass
	
func _input(event):
	if event.is_action_pressed("debugAction"):
		#print("Printing Actors...")
		if "idName" in navTarget and navTarget.idName == "DebugFlag":
			setNavigationTarget(ActorHandler.getActorById("Player"))
		else:
			setNavigationTarget(ActorHandler.getActorById("DebugFlag"))
	

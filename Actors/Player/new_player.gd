extends CharacterBody3D

# STATES
var Idle_State = preload("res://Actors/Player/States/Idle_State.gd")
var Running_Forward_State = preload("res://Actors/Player/States/Running_Forward_State.gd")
var currentState = Idle_State.new()

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002

var idName = "Player"
var characterType = "Protagonist"

func changeState(newStateName):
	if newStateName != currentState.stateName:
		match newStateName:
			"idle": 
				currentState = Idle_State.new()
			"running_forward":
				currentState = Running_Forward_State.new()
		currentState.enter()

func _ready():
	ActorHandler.registerActor(self)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	handle_movement(delta)
	handle_animation(delta)

func _input(event):
	if event.is_action_pressed("debugAction"):
		#print("Printing Actors...")
		for actor in ActorHandler.actors:
			#print(actor)
			pass
	if event.is_action_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("ui_accept") and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func handle_movement(delta):
	var pressed = get_pressed_actions()
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		velocity.x = movement_dir.x * speed
		velocity.z = movement_dir.z * speed
		
#	SET STATE BASED ON WHAT KEYS ARE PRESSED
	if(!pressed.has("forward") and !pressed.has("back")
		and !pressed.has("left") and !pressed.has("right")):
			changeState("idle")
	if(pressed.size() == 1 and pressed.has("forward")):
		changeState("running_forward")
	
	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		
func handle_animation(_delta):
	if (currentState.stateName == "running_forward"):
		$AnimationPlayer.play("RigAction")
		
# HELPER FUNCTION
func get_pressed_actions() -> Array:
	var pressed = []
	for action in InputMap.get_actions():
		if Input.is_action_pressed(action):
			pressed.append(action)
	return pressed

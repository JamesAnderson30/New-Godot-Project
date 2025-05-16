# TestFoe.gd
extends EnemyHandler
# class_name TestFoe # Not strictly needed if you only instance scenes

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

# Use an enum for state names for better type safety and autocompletion
enum States { IDLE, IN_AIR, CHASE_TARGET }

# Preload state scripts
const IdleState = preload("res://States/Idle_state.gd")
const InAirState = preload("res://States/In_Air_State.gd")
const ChaseTargetState = preload("res://States/Chase_Target_State.gd")
 
var current_state: State # Type hint for the base State class
var walkingSpeed: float = 3.0 # Made it a float for smoother speed control

func _ready() -> void:
	super._ready() # Call parent's _ready if it has one
	
	# REGISTER ACTOR
	# Assuming ActorHandler is an autoload/singleton
	if ActorHandler: # Check if ActorHandler exists
		ActorHandler.registerActor(self)
	else:
		print_warn("ActorHandler not found. Cannot register TestFoe.")

	# SET UP ENEMY PARAMETERS
	hp = 150 # Overrides base hp from EnemyHandler
	
	# Attempt to find Player, but handle if not found
	var player_node = ActorHandler.getActorById("Player") if ActorHandler else null
	if player_node:
		set_navigation_target(player_node)
	else:
		print_warn(name, ": Player not found by ActorHandler. No initial nav_target.")

	# SET VISUAL ATTRIBUTES
	var mesh_instance = $MeshInstance3D as MeshInstance3D
	if mesh_instance and mesh_instance.mesh and mesh_instance.mesh.material:
		var mat = mesh_instance.mesh.material.duplicate() # Duplicate material to avoid changing shared resource
		mat.albedo_color = Color.BLUE 
		mesh_instance.material_override = mat # Better to use material_override
	else:
		print_warn(name, ": Could not set mesh color. MeshInstance3D or material missing.")

	# Initialize to idle state
	# Note: state is instantiated here, not added as a child
	current_state = IdleState.new()
	current_state.enter(self)


func change_state(new_state_enum: States) -> void:
	if current_state and current_state.state_name == state_enum_to_string(new_state_enum):
		return # Already in this state

	if current_state:
		current_state.exit() # Call exit on the old state

	match new_state_enum:
		States.IDLE:
			current_state = IdleState.new()
		States.IN_AIR:
			current_state = InAirState.new()
		States.CHASE_TARGET:
			current_state = ChaseTargetState.new()
			# Special setup for ChaseTargetState if needed, e.g., passing nav_agent
			# (Though the state now gets it from the actor)
		_:
			printerr("Attempted to change to unknown state: ", new_state_enum)
			current_state = IdleState.new() # Default to idle on error

	current_state.enter(self) # Call enter on the new state
	# print(name, " changed to state: ", current_state.state_name)

# Helper to convert enum to string if needed for comparisons or preloading
# (though with direct preloads and enum matching, it's less critical)
func state_enum_to_string(state_enum: States) -> String:
	match state_enum:
		States.IDLE: return "idle"
		States.IN_AIR: return "in_air"
		States.CHASE_TARGET: return "chase_target"
	return ""

func _physics_process(delta: float) -> void:
	# --- Gravity ---
	if not is_on_floor():
		velocity.y -= gravity * delta
		# If not already in_air, the current state's physics_update should handle transitioning
		# (e.g., IdleState or ChaseTargetState returning "in_air")
	else:
		# Reset vertical velocity if on floor and not jumping
		# This can be tricky if states implement jumping.
		# For simplicity, if a state wants to jump, it should set velocity.y itself.
		# If just landed, velocity.y might still be negative from move_and_slide.
		# A common approach is to set velocity.y = -1 (or small negative) to keep it grounded.
		velocity.y = 0 # Simplified: If on floor, no external vertical velocity unless state applies it (e.g. jump)

	# --- State Logic ---
	if current_state:
		var next_state_name_str: String = current_state.physics_update(delta)
		if next_state_name_str != "":
			# Convert string back to enum to call change_state
			match next_state_name_str:
				"idle": change_state(States.IDLE)
				"in_air": change_state(States.IN_AIR)
				"chase_target": change_state(States.CHASE_TARGET)
				_: printerr(name, ": State ", current_state.state_name, " requested unknown next state '", next_state_name_str, "'")


	# --- Apply Movement ---
	# Velocity has been modified by gravity and the current state's physics_update
	move_and_slide()

# _process can be used for logic not tied to physics, like updating UI, non-physics animations
func _process(delta: float) -> void:
	if current_state:
		current_state.process_update(delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debugAction"):
		if nav_target and "idName" in nav_target and nav_target.idName == "DebugFlag":
			var player_node = ActorHandler.getActorById("Player") if ActorHandler else null
			if player_node: set_navigation_target(player_node)
		else:
			var debug_flag_node = ActorHandler.getActorById("DebugFlag") if ActorHandler else null
			if debug_flag_node: set_navigation_target(debug_flag_node)

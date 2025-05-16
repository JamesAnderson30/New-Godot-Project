# File: res://Actors/Enemies/States/Chase_Target_State.gd
extends State
# class_name ChaseTargetState

# This state needs access to the actor's NavigationAgent3D
var nav_agent: NavigationAgent3D

func _init():
	super._init()
	state_name = "chase_target" # Set the state_name

func enter(owner_actor: CharacterBody3D) -> void:
	super.enter(owner_actor)
	print(actor.name if actor else "Actor", " entered Chase Target State") # Modified your print slightly

	if not is_instance_valid(actor):
		printerr("ChaseTargetState: Actor is not valid on enter!")
		return

	# Get the NavigationAgent3D node from the actor.
	# This assumes the actor (e.g., TestFoe) has a child node named "NavigationAgent3D".
	if actor.has_node("NavigationAgent3D"):
		nav_agent = actor.get_node("NavigationAgent3D") as NavigationAgent3D
		if not nav_agent: # Check if casting failed
			printerr(actor.name, ": ChaseTargetState: Node 'NavigationAgent3D' is not of type NavigationAgent3D.")
	else:
		printerr(actor.name, ": ChaseTargetState: Actor does not have a NavigationAgent3D child node.")
		# Potentially transition to an error state or back to idle if nav_agent is crucial and missing.
		# For now, physics_update will also check nav_agent's validity.

	if actor.nav_target == null:
		print_debug(actor.name, ": ChaseTargetState entered without a nav_target. Will likely transition out quickly.")
	
	# Optional: Play running/chasing animation
	# if actor and "animation_player" in actor:
	#   actor.animation_player.play("run")

func exit() -> void:
	super.exit()
	# Stop movement when exiting chase state, unless the next state handles it.
	if is_instance_valid(actor):
		actor.velocity.x = 0
		actor.velocity.z = 0
	# print(actor.name if actor else "Actor", " exiting Chase Target State")


func physics_update(delta: float) -> String:
	if not is_instance_valid(actor):
		printerr("ChaseTargetState: Actor is not valid!")
		return "idle" # Or some error state

	# Transition condition: If in the air, switch to In_Air_State
	if not actor.is_on_floor():
		return "in_air"

	# Transition condition: If the navigation target is lost or becomes null
	if actor.nav_target == null:
		return "idle" # No target to chase, go idle

	# Ensure nav_agent is valid (could have failed in enter or been removed)
	if not is_instance_valid(nav_agent):
		printerr(actor.name, ": ChaseTargetState: nav_agent is not valid. Transitioning to idle.")
		return "idle"

	# Update the navigation agent's target position
	nav_agent.target_position = actor.nav_target.global_position
	
	# Check if navigation is finished (reached the target or cannot reach)
	if nav_agent.is_navigation_finished():
		# print_debug(actor.name, " navigation finished.")
		actor.velocity = Vector3.ZERO # Stop moving
		# What to do here? Attack? Go idle? For now, let's go idle.
		# You might want a new "attack" state or "reached_target" state.
		return "idle" 
		
	# Get the next position on the path and move towards it
	var next_path_pos: Vector3 = nav_agent.get_next_path_position()
	var direction: Vector3 = (next_path_pos - actor.global_position).normalized()
	
	# Access walkingSpeed from the actor (TestFoe must have this property)
	var current_walking_speed: float = 1.0 # Default speed
	if "walkingSpeed" in actor: # Check if the actor has 'walkingSpeed'
		current_walking_speed = actor.walkingSpeed
	
	actor.velocity.x = direction.x * current_walking_speed
	actor.velocity.z = direction.z * current_walking_speed
	# Y velocity (gravity) is handled by the main actor script

	# Optional: Make the actor look where it's going
	if direction != Vector3.ZERO:
		actor.look_at(actor.global_position + direction, Vector3.UP)

	return "" # Remain in "chase_target" state

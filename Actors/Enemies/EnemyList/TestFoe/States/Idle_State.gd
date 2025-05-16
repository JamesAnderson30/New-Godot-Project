# File: res://Actors/Enemies/States/Idle_state.gd
extends State
# class_name IdleState # Optional: if you want to reference it by class name elsewhere

func _init(): # Use _init for Objects, this runs when .new() is called
	super._init() # Call parent's _init if it has one
	state_name = "idle" # Set the state_name, matching your original

func enter(owner_actor: CharacterBody3D) -> void:
	super.enter(owner_actor) # Call parent's enter, which sets 'self.actor'
	print(actor.name if actor else "Actor", " entered Idle State") # Your original print
	
	# Optional: Ensure the actor stops moving when entering idle
	if actor: # actor might not be set if called before super.enter in a rare case
		actor.velocity.x = 0
		actor.velocity.z = 0
		# Note: Y velocity (gravity) is handled by the main actor script

func exit() -> void:
	super.exit()
	# print(actor.name if actor else "Actor", " exiting Idle State")

func physics_update(delta: float) -> String:
	# This check ensures 'actor' is valid before trying to use it.
	if not is_instance_valid(actor):
		printerr("IdleState: Actor is not valid!")
		return "" # Stay in idle or handle error

	# Transition condition: If in the air, switch to In_Air_State
	if not actor.is_on_floor():
		return "in_air"

	# Transition condition: If a navigation target is set, switch to Chase_Target_State
	# Assuming 'nav_target' is a property of your actor (EnemyHandler/TestFoe)
	if actor.nav_target != null:
		return "chase_target"
		
	# If on floor and no target, remain idle.
	# Velocity was already zeroed in enter(), but good to ensure if other states might set it.
	actor.velocity.x = 0
	actor.velocity.z = 0
	
	return "" # No state change, remain "idle"

# _process is generally not needed for simple idle, but if you had UI updates or non-physics checks:
# func process_update(delta: float) -> void:
#    super.process_update(delta)
#    pass

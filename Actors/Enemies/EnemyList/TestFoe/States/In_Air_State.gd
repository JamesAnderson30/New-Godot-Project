# File: res://Actors/Enemies/States/In_Air_State.gd
extends State
# class_name InAirState

func _init():
	super._init()
	state_name = "in_air" # Set the state_name

func enter(owner_actor: CharacterBody3D) -> void:
	super.enter(owner_actor)
	print(actor.name if actor else "Actor", " entered ", state_name, " state") # Your original print
	# Optional: Play a falling animation
	# if actor and "animation_player" in actor:
	#   actor.animation_player.play("fall")

func exit() -> void:
	super.exit()
	# print(actor.name if actor else "Actor", " exiting InAir State")

func physics_update(delta: float) -> String:
	if not is_instance_valid(actor):
		printerr("InAirState: Actor is not valid!")
		return ""

	# Gravity is applied by the main actor script (e.g., TestFoe._physics_process)
	# This state's primary job is to check if the actor has landed.
	
	if actor.is_on_floor():
		# Once landed, decide the next state based on conditions
		if actor.nav_target != null:
			return "chase_target" # Landed and has a target, so chase
		else:
			return "idle" # Landed and no target, so go idle
			
	return "" # Remain in "in_air" state until landed

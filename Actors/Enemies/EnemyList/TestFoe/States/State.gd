# Base State Script
class_name State
extends Object # Not a Node!

# A reference to the actor this state belongs to (e.g., the TestFoe)
var actor: CharacterBody3D 
var state_name: String = "BaseState" # For debugging or comparison

# Called when the state is entered.
# The 'owner_actor' is the CharacterBody3D (TestFoe) this state will control.
func enter(owner_actor: CharacterBody3D) -> void:
	self.actor = owner_actor
	# print(actor.name, " entering state: ", state_name)

# Called when the state is exited.
func exit() -> void:
	# print(actor.name, " exiting state: ", state_name)
	pass

# Called during the actor's _process loop.
func process_update(_delta: float) -> void:
	pass

# Called during the actor's _physics_process loop.
# Should typically return a String with the name of the next state, or null if no change.
func physics_update(_delta: float) -> String:
	return "" # Return empty string or specific state name to transition

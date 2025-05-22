extends CharacterBody3D
class_name EnemyHandler

@export var hp: int = 100
@export var gravity: float = 9.8 # ProjectSettings.get_setting("physics/3d/default_gravity") is better

var nav_target: Node3D = null # More specific type if possible, e.g., Node3D

# It's good practice to initialize velocity
func _init():
	velocity = Vector3.ZERO

func set_navigation_target(new_target: Node3D) -> void:
	nav_target = new_target
	# Optional: Emit a signal if other things need to know the target changed
	# emit_signal("navigation_target_changed", new_target)

# _ready is fine to be empty if no setup is needed AT THIS LEVEL.
# Subclasses will use their own _ready.
func _ready() -> void:
	pass

# _process is also fine to be empty.
# Subclasses or states will handle per-frame logic.
func _process(_delta: float) -> void:
	pass

# It can be useful to have a virtual method for taking damage
func take_damage(amount: int) -> void:
	hp -= amount
	print(name, " took ", amount, " damage. HP left: ", hp)
	if hp <= 0:
		die()

# Virtual method for death, subclasses can override
func die() -> void:
	print(name, " has died.")
	# Example: queue_free(), play animation, drop loot, etc.
	queue_free()

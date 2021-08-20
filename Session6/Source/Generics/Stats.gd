extends Node

# inspector settable health
export(int) var max_health = 1 setget set_max_health

# internal health
var health = max_health setget set_health

# Signals: events when something happens

# Health gone
signal no_health

# Health changed
signal health_changed(value)

# Max health update - LEVEL UP
signal max_health_changed(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the health to max_health
	self.health = max_health
	

func set_health(value):
	# Change the health
	health = value
	# Emit the signals
	emit_signal("health_changed", health)
	
	# is health 0
	if health <= 0:
		emit_signal("no_health")

# LEVEL UP - MAX GETS BIGGER
func set_max_health(value):
	max_health = value
	
	# Change active health
	self.health = min(health, max_health)
	
	# Emit the signal
	emit_signal("max_health_changed", max_health)

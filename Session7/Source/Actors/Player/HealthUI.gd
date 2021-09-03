extends Control


# Get the heart containers
onready var fullHearts = $FullHearts
onready var emptyHearts = $EmptyHearts

# Health
var health = 4 setget set_health

# Max Health
var max_health = 4 setget set_max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get player's health
	self.max_health = PlayerStats.max_health
	self.health = PlayerStats.health
	# Set health values for UI
	PlayerStats.connect("health_changed", self, "set_health")
	PlayerStats.connect("max_health_changed", self, "set_max_health")


func set_health(value):
	print("Called in HealthUI set health %d" % value)
	health = clamp(value, 0, max_health)
	print(health)
	
	# change heart UI size
	if fullHearts != null:
		fullHearts.rect_size.x = health * 15
	

func set_max_health(value):
	max_health = max(value, 1)
	self.health = min(health, max_health)
	
	# set default heart UI size
	if emptyHearts != null:
		emptyHearts.rect_size.x = max_health * 15
	

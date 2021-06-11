extends KinematicBody2D

# Typing a comment

var velocity = Vector2.ZERO

# How fast can we go?
export var MAX_SPEED = 80

# What slows us?
export var FRICTION = 500

# How fast we speed up?
export var ACCELERATION = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_state(delta)

# decide how we move?
func move_state(delta):
	# calculate input speed
	var input_vector = Vector2.ZERO
	# separate into x and y
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# call a math function to make it nicer aka "normalize" 1
	input_vector = input_vector.normalized()
	
	# If input is there?
	if input_vector != Vector2.ZERO:
		
		# Set velocity so we actually can move, we will do more here later!
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	# No input?
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# We calculated, now move!
	move()

# actually move
func move():
	velocity = move_and_slide(velocity)

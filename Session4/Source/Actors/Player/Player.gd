extends KinematicBody2D

var velocity = Vector2.ZERO

# How fast can we go?
export var MAX_SPEED = 80

# What slows us?
export var FRICTION = 500

# How fast we speed up?
export var ACCELERATION = 500

export var ROLL_SPEED = 120

# calculate input speed
var input_vector = Vector2.ZERO
var roll_vector = Vector2.ZERO

# This is how we check what to animate?
enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		MOVE:
			# Moving
			move_state(delta)		
		ROLL:
			roll_state()
		
		ATTACK:
			attack_state()

# decide how we move?
func move_state(delta):

	# separate into x and y
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	
	# call a math function to make it nicer aka "normalize" 1
	input_vector = input_vector.normalized()
	
	# If input is there?
	if input_vector != Vector2.ZERO:
		
		# Animate the character
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		# Set velocity so we actually can move, we will do more here later!
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	# No input?
	else:
		# call idle animation
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# We calculated, now move!
	move()
	
	# DID WE CHANGE INPUT??
	if (Input.is_action_just_pressed("attack")):
		state = ATTACK
	
	if (Input.is_action_just_pressed("roll")):
		state = ROLL

# actually move
func move():
	velocity = move_and_slide(velocity)
	
func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

func roll_state():
	velocity = input_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE

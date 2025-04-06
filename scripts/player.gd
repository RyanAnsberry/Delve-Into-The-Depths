extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var move_speed = 125
@export var jump_force = 200

@onready var animated_sprite = $AnimatedSprite2D

var active = true
var is_swinging = false

func _physics_process(delta: float) -> void:
	# apply gravity when not on floor
	if !is_on_floor():
		velocity.y += gravity * delta
		# limit the falling velocity
		if velocity.y >= 500:
			velocity.y = 500
	
	var direction = 0
		
	if active:
		# jump input
		if Input.is_action_pressed("jump") and is_on_floor():
			jump(jump_force)
			
		if Input.is_action_pressed("swing") and is_on_floor() and !is_swinging:
			swing()
		
		# movement input
		direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	# update animation based on direction
	if is_swinging:
		velocity = Vector2.ZERO
	else:
		# movement
		velocity.x = direction * move_speed
		move_and_slide()
		update_animations(direction)

func swing():
	is_swinging = true
	animated_sprite.play("swing")
	await get_tree().create_timer(0.6).timeout
	is_swinging = false

func jump(force):
	velocity.y = -force

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		elif -15.0 < velocity.y and velocity.y < 15.0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("fall")

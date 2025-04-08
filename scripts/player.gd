extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var move_speed = 125
@export var climb_speed = 50
@export var jump_force = 200
@export var reach = 24.0

@onready var animated_sprite = $AnimatedSprite2D

var active = true
var is_swinging = false
var can_climb = false

func _physics_process(delta: float) -> void:
# apply gravity when not on floor
	if !is_on_floor():
		velocity.y += gravity * delta
		# limit the falling velocity
		if velocity.y >= 500:
			velocity.y = 500
	
	var direction = Vector2.ZERO
	
	if active:
		# jump input
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump(jump_force)
		
		if Input.is_action_just_pressed("swing") and is_on_floor():
			swing()
		
		# movement input
		if can_climb:
			direction = Vector2(Input.get_axis("move_left","move_right"), Input.get_axis("climb_up", "climb_down"))
		else:
			direction.x = Input.get_axis("move_left", "move_right")
	if direction.x != 0:
		animated_sprite.flip_h = (direction.x == -1)

	if is_swinging:
		velocity = Vector2(0, velocity.y)
	elif can_climb:
		velocity = Vector2(direction.x * (move_speed / 2), direction.y * climb_speed)
		update_animations(direction)
	else:
		# movement
		velocity = Vector2(direction.x * move_speed, velocity.y)
		# update animation based on direction
		update_animations(direction)
	move_and_slide()


func swing():
	is_swinging = true
	animated_sprite.play("swing")
	await get_tree().create_timer(0.3).timeout
	is_swinging = false

func jump(force):
	velocity.y = -force

func update_animations(direction):
	if is_on_floor():
		if direction.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	elif can_climb and direction.y == 0:
		animated_sprite.play("climb_idle")
	elif can_climb and (direction.y > 0 or direction.y < 0):
		animated_sprite.play("climb")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		elif -15.0 < velocity.y and velocity.y < 15.0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("fall")

func set_can_climb(value: bool):
	can_climb = value

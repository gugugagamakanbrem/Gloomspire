extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const MAX_JUMPS = 2   # <- 2 = double jump

@onready var animated_sprite = $AnimatedSprite2D

var jump_count = 0

func _physics_process(delta: float) -> void:
	# Gravitasi
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Reset jump kalau di tanah
		jump_count = 0

	# Lompat + Double Jump
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Gerakan kiri/kanan
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animasi idle
	if velocity.x == 0:
		animated_sprite.play("idle")

	# Flip arah
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	move_and_slide()

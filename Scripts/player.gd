extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Dapatkan node AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Tambahkan gravitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Tangani lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Tangani pergerakan
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Mainkan animasi "idle" jika karakter tidak bergerak horizontal
	if velocity.x == 0:
		animated_sprite.play("idle")
	# Atur arah flip horizontal
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	move_and_slide()

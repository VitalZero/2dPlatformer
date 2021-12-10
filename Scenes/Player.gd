extends KinematicBody2D

#globales
var vel = Vector2.ZERO
var dir:Vector2
var coinCount:int = 0

#exportables
export var SPEED:float = 220
export var GRAVITY:float = 35
export var JUMP_SPEED:float = -900

#onready
onready var animatedSprite = $AnimatedSprite

#functions
func play_coin_sound():
	$CoinSound.play()

func _physics_process(delta):
	dir = Vector2.ZERO

	vel.y += GRAVITY

	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

	if dir.x > 0:
		animatedSprite.flip_h = false
	elif dir.x < 0:
		animatedSprite.flip_h = true

	if is_on_floor():
		if dir.x != 0:
			animatedSprite.play("walk")
		else:
			animatedSprite.play("idle")

		if Input.is_action_pressed("crouch"):
			dir.x = 0
			animatedSprite.play("crouch")
		elif Input.is_action_just_pressed("jump") and is_on_floor():
			vel.y = JUMP_SPEED
			$JumpSound.play()

	elif not is_on_floor():
		if vel.y < 0:
			animatedSprite.play("air")
		elif vel.y > 0:
			animatedSprite.play("fall")

	#vel.x = dir.x * SPEED
	vel.x = lerp(vel.x, dir.x * SPEED, .2)

	vel = move_and_slide(vel, Vector2.UP)
	


func _on_FallZone_body_entered(body):
	print(body.name)
	if(body.name == "Player"):
		$RespawnTimer.start(2)

func _on_RespawnTimer_timeout():
	get_tree().change_scene("res://Scenes/Level.tscn")

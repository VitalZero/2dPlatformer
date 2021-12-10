extends KinematicBody2D

var velocity = Vector2()

export var dir:int = -1
export var SPEED:float = 50
export var GRAVITY:float = 35

func _ready():
	if dir == 1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	
	if is_on_wall():
		dir = dir * -1
		
	if dir == 1:
		$AnimatedSprite.flip_h = true
	elif dir == -1:
		$AnimatedSprite.flip_h = false
		
	velocity.y += GRAVITY
	velocity.x = dir * SPEED
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	

extends CharacterBody2D

const angles = 4
const total_angle = 8
var animations_angle: Array = ['right', 'down_right', 'down', 'down_left', 'left', 'up_left', 'up', 'up_right']

@export var use_mouse: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

func _ready():
	animated_sprite.play()

func _physics_process(delta) -> void:
	if use_mouse:
		mov_mouse()
	else:
		mov_keyboard()


func mov_keyboard() -> void:
	var moviment: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if moviment.length() != 0:
		var angle: float = moviment.angle() / (PI/angles)
		var angle_index: int = wrapi(int(angle), 0, total_angle)
		var animation = animations_angle[angle_index]
		animated_sprite.animation = 'walk_' + animation
	
	else:
		animated_sprite.animation = 'idle_' + '0'
		
	animated_sprite.play()
	move_and_slide()

func mov_mouse() -> void:
	var mouse: Vector2 = get_global_mouse_position()
	var angle: float = snappedf(mouse.angle(), PI/angles) / (PI/angles)
	var angle_index: int = wrapi(int(angle), 0, total_angle)
	var animation = animations_angle[angle_index]
	animated_sprite.play('walk_' + animation)

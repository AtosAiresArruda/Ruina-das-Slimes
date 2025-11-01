extends Node2D

@export var enemy_scene: PackedScene
@export var interval: float = 2.0
@onready var player: Node2D = $"../Player"
@onready var camera: Camera2D = player.get_node("Camera2D")

func _ready():
	call_deferred("timer")

func spawn_enemy() -> void:
	if enemy_scene == null:
		return 

	var enemy = enemy_scene.instantiate()
	var side = randi() % 4
	var position = Vector2.ZERO #inializa position

	# get camera bounds
	var viewport_rect = get_viewport_rect()
	var cam_pos = camera.global_position
	var camera_bounds = Rect2(cam_pos - viewport_rect.size / 2, viewport_rect.size)

	match side:
		0:  #left #change change to -50 if on center
			position.x = camera_bounds.position.x - 50
			position.y = randf_range(camera_bounds.position.y, camera_bounds.end.y)
		1:  # right #change to +50 if on center
			position.x = camera_bounds.end.x + 50
			position.y = randf_range(camera_bounds.position.y, camera_bounds.end.y)
		2:  # top
			position.y = camera_bounds.position.y - 50
			position.x = randf_range(camera_bounds.position.x, camera_bounds.end.x)
		3:  # bottom
			position.y = camera_bounds.end.y + 50
			position.x = randf_range(camera_bounds.position.x, camera_bounds.end.x)

	enemy.global_position = position
	enemy.player = player
	get_parent().call_deferred("add_child", enemy)

func timer():
	spawn_enemy()
	await get_tree().create_timer(interval).timeout
	timer()

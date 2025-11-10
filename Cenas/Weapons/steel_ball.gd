extends Area2D

@export var radius: float = 48.0
@export var rotation_speed: float = 2.5
@export var damage:float
@export var lifetime: float = 4

var player: Node2D
var angle: float = 0.0

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	if player == null:
		return

	angle += rotation_speed * delta
	global_position = player.global_position + Vector2(radius, 0).rotated(angle)

func _on_body_entered(body):
	if body.is_in_group("enemys") and body.has_method("take_damage"):
		body.take_damage(damage)

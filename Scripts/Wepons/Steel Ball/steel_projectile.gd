extends Node2D

@export var player: Node2D
var start_angle: float
var radius: float
var rotation_speed: float
var damage: float

var angle := 0.0

func _ready():
	angle = start_angle

func _physics_process(delta):
	if player == null:
		return

	angle += rotation_speed * delta

	var offset = Vector2(
		cos(angle) * radius,
		sin(angle) * radius
	)

	global_position = player.global_position + offset


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemys") and body.has_method("take_damage"):
		body.take_damage(damage)

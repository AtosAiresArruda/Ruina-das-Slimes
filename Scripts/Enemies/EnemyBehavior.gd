extends CharacterBody2D

@export var speed: float = 100.0
@export var max_life: float = 10.0
@export var collision_distance: float = 16.0
@export var push_force: float = 0.2
@export var damage: float = 2.5
var xp_gem = preload("res://Cenas/Player/EXPCrystal.tscn")
@onready var sprite = $AnimatedSprite2D


var life: float
var player: CharacterBody2D

func _ready():
	life = max_life

func _physics_process(delta: float):
	if player == null:
		return

	var direction: Vector2 = (player.global_position - global_position).normalized()
	velocity = direction * speed

	if player.life >= 1:
		move_and_slide()
		_overlapping_handler()

func _overlapping_handler():
	if player == null:
		return

	var to_player = player.global_position - global_position
	var distance = to_player.length()

	if distance < collision_distance:
		var push_dir = -to_player.normalized()
		var needed_push = (collision_distance - distance) + collision_distance * 2
		global_position += push_dir * needed_push

func flash_white(duration := 0.1):
	
	var tween = create_tween()
	# Fade out (alpha 1 → 0)
	tween.tween_property(sprite, "modulate:a", 0.0, duration * 0.5)
	# Fade in (alpha 0 → 1)
	tween.tween_property(sprite, "modulate:a", 1.0, duration * 0.5)
	
func take_damage(amount: float = 1.0) -> void:
	life -= amount
	flash_white()
	if life <= 0:
		die()

func spawn_xp() -> void:
	if xp_gem == null:
		push_error("xp_gem is NULL! Assign it in the Inspector.")
		return
	var xp_instance = xp_gem.instantiate()
	if xp_instance == null:
		push_error("xp_gem failed to instantiate!")
		return

	xp_instance.global_position = global_position
	get_parent().add_child(xp_instance)

func die() -> void:
	call_deferred("spawn_xp")
	call_deferred("queue_free")

func get_damage() -> float:
	return damage

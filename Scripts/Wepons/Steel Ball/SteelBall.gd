extends Node2D

@export var orb_scene: PackedScene
@export var projectile_count: int = 1 : set = set_projectile_count
@export var radius: float = 10
@export var rotation_speed: float = 2.0
@export var damage: float = 10.0

var player: Node2D
var orbs: Array = []


func get_weapon_type() -> String:
	return "OrbWeapon"
	
func setup(_player):
	player = _player
	call_deferred("_spawn_all_orbs")
	

func _ready():
	pass

func set_projectile_count(value):
	projectile_count = value
	call_deferred("_rebuild_orbs")

func _rebuild_orbs():
	for orb in orbs:
		orb.queue_free()
	orbs.clear()
	call_deferred("_spawn_all_orbs")
	

func _spawn_all_orbs():
	if player == null:
		await get_tree().process_frame

	if projectile_count <= 0:
		return

	var angle_step = TAU / projectile_count

	for i in range(projectile_count):
		var orb = orb_scene.instantiate()
		orb.player = player
		orb.start_angle = i * angle_step
		orb.rotation_speed = rotation_speed
		orb.radius = radius
		orb.damage = damage

		add_child(orb)
		orbs.append(orb)

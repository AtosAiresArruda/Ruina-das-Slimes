extends Area2D

@export var speed := 200.0
@export var radius := 120
var player_area = null
var player = null

func _ready():
	player_area = get_tree().get_first_node_in_group('Player')
	player=player_area.get_parent()

func _physics_process(delta: float) -> void:
	if player == null:
		return
	var distance = global_position.distance_to(player.global_position)
	if distance < radius :
		var direction = (player.global_position - global_position).normalized()
		global_position+=direction*speed*delta



func _on_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		call_deferred("queue_free")
		player.getExp(20)

extends  CharacterBody2D

@export var speed: float = 100.0
@export var collision_distance:float = 16.0
@export var push_force: float = 0.2

var player: CharacterBody2D = null

func _physics_process(delta: float):
	if player == null:
		return
	var direction: Vector2 = (player.position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

	_overlapping_handler()
	
func _overlapping_handler():
	if player == null:
		return
	var distance = (player.global_position - global_position).length()
	if distance < collision_distance:
		#direcao do empurrao = direcao do vetor invertido
		var push =- (player.global_position - global_position).normalized()
		#aplica o empurrao proporcional a distancia multiplicado ajuste de forca (esse ajuste é geralmente um valor entre 0 e 1 onde 1 é a distancia total)
		#quanto maior o valor de push_force, mais rapido o inimigo sera empurrado para fora [pode causar impressao de teleporte]
		global_position+=push*(collision_distance - distance) * push_force

extends CharacterBody2D

#States
enum {
	ALIVE,
	DEAD
}

#Status Base
@export var SPEED:float = 200.0
@export var life : float = 100
var state = ALIVE

#Atributos
var mov_effect = 1 #Porcentagem de bonus ou debuff de velocidade


func _physics_process(delta: float) -> void:
	# Left Right Down Up são entradas mapeadas ao teclado
	#Direction é um vetor de duas coordenadas
	#Get_vector é uma função que retorna um Vector2 utilizando OU exclusivo
	var direction := Input.get_vector("Left", "Right", "Up", "Down").normalized()
	

	if state == ALIVE:
		velocity = direction * SPEED * mov_effect #MOVIMENTAÇÃO
	else:
		velocity = Vector2(0,0)
	move_and_slide()

#Regras de Colisão para dano aqui!
func _on_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemys") and state == ALIVE:
		print(life)
		life -= body.get_damage()
		if life <= 0:
			life =0
			state = DEAD

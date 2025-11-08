extends CharacterBody2D

#Status Base
@export var SPEED:float = 200.0
var life = 100

#Atributos
var mov_effect = 1 #Porcentagem de bonus ou debuff de velocidade


func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	# Left Right Down Up são entradas mapeadas ao teclado
	#Direction é um vetor de duas coordenadas
	#Get_vector é uma função que retorna um Vector2 utilizando OU exclusivo
	var direction := Input.get_vector("Left", "Right", "Up", "Down").normalized()
	print(life)

	if life > 0:
		velocity = direction * SPEED * mov_effect #MOVIMENTAÇÃO
	else:
		velocity = Vector2(0,0)	
	move_and_slide()

#Regras de Colisão para dano aqui!
func _on_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemys"):
		print("Dano")
		life -=1

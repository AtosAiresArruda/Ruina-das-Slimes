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
	if life > 0:
		velocity = direction * SPEED * mov_effect #MOVIMENTAÇÃO
	else:
		velocity = Vector2(0,0)
	

	


	move_and_slide()

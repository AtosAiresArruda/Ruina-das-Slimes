extends CharacterBody2D

#ArmaComplicada atualiza isso na hora da criação desse obj
var angle = 1
var speed = 0
var direction = Vector2(0,0)
var damage = 0
var countEnemy = 0 #Contador de acertos
var maxCountEnemy = 3 #Quanto inimigos pode acertar até desaparecer
#var sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	rotation = angle
	velocity = direction * speed
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(damage)
	
	if body.is_in_group("enemys"):
		body.take_damage(damage)
		countEnemy +=1 #Acertei um alvo
		damage *= 0.7 #Diminui o dano após acertar um alvo
		
		if countEnemy >= maxCountEnemy:
			queue_free()

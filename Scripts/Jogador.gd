extends CharacterBody2D


#Weapons
@onready var weapon_manager = $WeaponManager
@export var steel_ball: PackedScene

#States
enum {
	ALIVE,
	DEAD
}

#Status Base
@export var SPEED:float = 200.0
@export var life : float = 100
@onready var sprite = $AnimatedSprite2D
var state = ALIVE

#Atributos
var mov_effect = 1 #Porcentagem de bonus ou debuff de velocidade

func _ready() -> void:
	weapon_manager.player = self
	print("WeaponManager ready!")
	if weapon_manager.player == null:
		print("⚠️ No player set in WeaponManager")
		return
	weapon_manager.add_weapon(preload("res://Cenas/Weapons/Steel Ball.tscn"), 5)


func flash_white(duration := 0.1):
	var tween = create_tween()
	# Fade out (alpha 1 → 0)
	tween.tween_property(sprite, "modulate:a", 0.0, duration * 0.5)
	# Fade in (alpha 0 → 1)
	tween.tween_property(sprite, "modulate:a", 1.0, duration * 0.5)

func _physics_process(delta: float) -> void:
	# Left Right Down Up são entradas mapeadas ao teclado
	#Direction é um vetor de duas coordenadas
	#Get_vector é uma função que retorna um Vector2 utilizando OU exclusivo
	var direction := Input.get_vector("Left", "Right", "Up", "Down").normalized()
	

	if state == ALIVE:
		velocity = direction * SPEED * mov_effect #MOVIMENTAÇÃO
		if velocity.length() > 0:
			sprite.play("Running")
			if velocity.x > 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
		else:
			sprite.play("idle")
		move_and_slide()
	else:
		sprite.play("idle")
		velocity = Vector2(0,0)
		get_tree().change_scene_to_file("res://Cenas/MainMenu.tscn")
		

#Regras de Colisão para dano aqui!
func _on_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemys") and state == ALIVE:
		print(life)
		flash_white()
		life -= body.get_damage()
		
		if life <= 0:
			life =0
			state = DEAD

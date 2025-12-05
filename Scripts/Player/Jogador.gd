extends CharacterBody2D


#Weapons
@onready var weapon_manager = $WeaponManager
@export var steel_ball = Area2D


#States
enum {
	ALIVE,
	DEAD
}

#Status Base
@export var SPEED:float = 125.0
@export var life : float = 100
@export var level: int = 1
@export var xp: float = 0
@export var next_level: float = 100
@onready var sprite = $AnimatedSprite2D
@onready var hp_bar = $LifeBar
@onready var total_xp = 0
@onready var xp_bar = $PlayerResources/Control/XPBar
var orb_weapon_scene = preload("res://Cenas/Weapons/Steel Ball/Steel Ball.tscn")
var state = ALIVE

#Atributos
var mov_effect = 1 #Porcentagem de bonus ou debuff de velocidade

func _ready() -> void:
	steel_ball = weapon_manager.add_weapon(orb_weapon_scene)
	self.xp_bar.value = 0.00
	self.xp_bar.max_value = next_level
	self.hp_bar.max_value = life
	self.hp_bar.value=life
	weapon_manager.player = self
	print("WeaponManager ready!")
	if weapon_manager.player == null:
		print("⚠️ No player set in WeaponManager")
		return


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
		if velocity != Vector2(0,0):
			#Estou andando
			sprite.play("Running")
			if velocity.x > 0:	
				sprite.flip_h = false
			#Elif para que quando o jogador apenas ande para cima, ou baixo não faça nenhuma alteração.
			elif velocity.x < 0: 
				sprite.flip_h = true
		else:
			#Estou parado
			sprite.play("idle")
	else:
		#Estou diferente de Alive
		sprite.play("idle")
		get_tree().change_scene_to_file("res://Cenas/MainMenu.tscn")
	move_and_slide()

#Regras de Colisão para dano aqui!
func _on_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemys") and state == ALIVE:
		print("HP: ",life) #debugging
		flash_white()
		hp_bar.value -= body.get_damage()
		life -= body.get_damage()
		if life <= 0:
			state = DEAD



func getExp(xp_value: float)->void:
	xp += xp_value
	total_xp+=xp_value
	print("EXP :",xp )
	if(xp>next_level):
		var aux = next_level - xp
		levelup()
		xp = aux
	xp_bar.value=xp
	
func levelup() -> void:
	next_level = (next_level*1.5); #curva de xp
	level+=1
	if steel_ball:
		steel_ball.projectile_count += 1
	print("LEVEL UP! - Level: ",level)
	print("Next Level:", next_level)
	print("Total Experience:", total_xp)
	xp_bar.max_value=next_level
		
	   
	   

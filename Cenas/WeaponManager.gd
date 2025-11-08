extends Node

# Dicionario de Armas
# { "scene": PackedScene, "cooldown": float, "last_fire_time": float }
var player: Node2D
var weapons: Array = []

func add_weapon(scene: PackedScene, cooldown: float):
	weapons.append({
		"scene": scene, # Passar caminho da cena
		"cooldown": cooldown,  #usar valores de 0 - 1
		"last_fire_time": 0.0
	})

func _process(delta):
	for weapon_data in weapons:
		var time_now = Time.get_ticks_msec() / 1000.0
		if time_now - weapon_data["last_fire_time"] >= weapon_data["cooldown"]:
			fire_weapon(weapon_data)
			weapon_data["last_fire_time"] = time_now
			

func fire_weapon(weapon_data):
	var player = get_parent() 
	if player == null:
		return
		
	var weapon_instance = weapon_data["scene"].instantiate()
	weapon_instance.global_position = player.global_position
	weapon_instance.player = player
	get_parent().add_child(weapon_instance)
	print()

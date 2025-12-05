extends Node

var player: Node2D
var weapons: Array = []

func _ready():
	player = get_parent()

func add_weapon(weapon_scene: PackedScene):
	var weapon = weapon_scene.instantiate()

	#1
	add_child(weapon)
	# 2
	weapon.player = player
	# 3
	if weapon.has_method("setup"):
		weapon.setup(player)
	# 4.
	weapons.append(weapon)

	return weapon


# Upgrade any attribute on ANY weapon
func upgrade_weapon(weapon_type: String, attribute: String, value):
	for weapon in weapons:
		if weapon.has_method("get_weapon_type") and weapon.get_weapon_type() == weapon_type:
			if weapon.has_variable(attribute):
				weapon.set(attribute, value)

				if attribute == "projectile_count":
					if weapon.has_method("_rebuild_orbs"):
						weapon._rebuild_orbs()

				return weapon

	return null

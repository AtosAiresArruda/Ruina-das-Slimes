extends Node2D

@export var projetilSpeed : float = 20
@export var fireTime: float = 2.5
@export var damage:float
@export var lifetime: float = 4

var player: Node2D
var targetList : Array[Node2D] = []
var target : Node2D = null
const BULLET = preload("res://Cenas/Weapons/Bullet.tscn")
 
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

	#await get_tree().create_timer(lifetime).timeout
	#queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if player == null:
	#	return
	
	fireTime -= delta
	
	target = selectTarget() #Encontra inimigo mais proximo
	updateAngle(target)
	
	if target:
		
		if fireTime <= 0:
			fire(target)
			fireTime = 2.5


func _on_area_2d_body_entered(body: Node2D) -> void:
	#Verifica se o inimigo está na lista de alvos, se não estiver o adicione.
	if body.is_in_group("enemys"):
		if not targetList.has(body):
			targetList.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	
	if targetList.has(body):
		targetList.erase(body)


func selectTarget() -> Node2D:
	var minorDistance = INF
	var selectTarget: Node2D = null
	
	for wouldTarget in targetList:
		if not is_instance_valid(wouldTarget):
			continue
		
		var distanceTarget = wouldTarget.global_position - self.global_position
		
		var distanceSquare = distanceTarget.length_squared()
		
		if distanceSquare < minorDistance:
			minorDistance = distanceSquare
			selectTarget = wouldTarget
	return selectTarget
	
func updateAngle(target : Node2D) -> void:
	if !target:
		self.rotation = 0
		return
	var direction = target.global_position - self.global_position
	
	self.rotation = direction.angle()

func fire(target : Node2D) -> void:
	
	var projetil = BULLET.instantiate()
	get_parent().add_child(projetil)
	projetil.global_position = self.global_position
	projetil.angle = (target.global_position - self.global_position).angle()
	projetil.speed = projetilSpeed

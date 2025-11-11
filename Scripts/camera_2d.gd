extends Camera2D

#var speed = 0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	zoom = Vector2(3,3)
	pass
	
	
func _physics_process(delta: float) -> void:
	#ar input_vec = Input.get_vector("Left","Right","Up","Down")
	#global_translate(input_vec*speed*delta)
	pass

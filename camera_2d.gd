extends Camera2D

var speed = 200
# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	var input_vec = Input.get_vector("Left","Right","Up","Down")
	global_translate(input_vec*speed*delta)

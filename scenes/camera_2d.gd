extends Camera2D

var DEFAULT_STH = 8

var shake_running = false
var sth = DEFAULT_STH

func _process(delta: float) -> void:
	if(shake_running):
		sth = lerpf(sth, 0, delta * 10)
		offset = Vector2(randf_range(-sth,sth), randf_range(-sth,sth))
		
		print(offset)

func shake():
	sth = DEFAULT_STH
	shake_running = true
	
	await get_tree().create_timer(1).timeout
	
	shake_running = false

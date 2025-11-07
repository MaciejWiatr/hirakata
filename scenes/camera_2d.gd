extends Camera2D

var DEFAULT_STH = 20

var shake_running = false
var sth = DEFAULT_STH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(shake_running):
		sth = lerpf(sth, 0, delta)
		offset = Vector2(randf_range(-sth,sth), randf_range(-sth,sth))
		print(offset)
		if offset[0] < 2:
			shake_running = false
			offset = Vector2.ZERO

func shake():
	sth = DEFAULT_STH
	shake_running = true

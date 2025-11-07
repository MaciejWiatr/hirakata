extends RigidBody2D

var sign = ""
var screen_center = Vector2.ZERO
var force = 2

func setup(_start_position: Vector2, _screen_center: Vector2, _sign: String) -> void:
	sign = _sign
	screen_center = _screen_center


func _ready() -> void:
	var animations : PackedStringArray = $MainSprite.sprite_frames.get_animation_names()
	var random_animation = animations[randi_range(0,animations.size()-1)]
	
	$MainSprite.animation = random_animation
	$MainSprite.speed_scale = 1.5
	$Label.text = sign
	

func remove() -> void:
	self.constant_force.x = randi_range(-6,6) * 100
	self.constant_torque = randi_range(-4,4) * 100
	
	$Label.text = ""
	$MainSprite.set_frame_and_progress(1,1.0)
	self.freeze = false
	$CPUParticles2D.emitting = true
		
	await get_tree().create_timer(0.3).timeout
	
	$MainSprite.set_frame_and_progress(2,1.0)
	
	await get_tree().create_timer(1).timeout
	queue_free()
	

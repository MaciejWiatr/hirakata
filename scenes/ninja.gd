extends Area2D

var base_position: Vector2
var tween: Tween = null

func _ready() -> void:
	base_position = self.global_position
		
func animate_cut() -> void:
	if tween:
		tween.kill()
	
	var camera = $"../Camera2D"
	var camera_center:Vector2 = camera.get_screen_center_position()
	
	$AnimatedSprite2D.play("jump")
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", self.position + Vector2(0, -50), 0.1)
	#await $AnimatedSprite2D.animation_finished
	
	$AnimatedSprite2D.play("fly")
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "global_position", camera_center + Vector2(120,-20), 0.2)
	await tween.finished
	
	$AnimatedSprite2D.speed_scale = 2.5
	$AnimatedSprite2D.play("slash")	
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.speed_scale = 1.5
	
	$AnimatedSprite2D.play("fly")
	tween = create_tween()
	tween.tween_property(self, "global_position", base_position, 0.2)
	await tween.finished
	
	# Play jump backwards at 1.5x speed
	$AnimatedSprite2D.play("jump", -1.5, true)
	await $AnimatedSprite2D.animation_finished
	
	$AnimatedSprite2D.play("idle")

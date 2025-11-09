extends AnimatedSprite2D

func hit() -> void:
	for p in self.find_children("CPUParticles2D"):
		p.global_position = self.global_position
		p.emitting = true
	
	self.set_frame_and_progress(1, 0)
	
	await get_tree().create_timer(1).timeout
	
	self.set_frame_and_progress(2,0)

extends Node2D

var state = [1,1,1]
@onready var hearts = [$Heart, $Heart2, $Heart3]

func take_hit() -> bool:
	if !hearts:
		return false
	
	for i in state.size():
		if state[i] == 1:
			state[i] = 0
			hearts[i].hit()
			
			return true
	
	return false

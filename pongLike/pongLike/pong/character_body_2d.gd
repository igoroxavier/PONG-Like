extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		self.position.y = self.position.y - 300 * delta
	if Input.is_action_pressed("move_down"):
		self.position.y = self.position.y + 300 * delta

extends CharacterBody2D

@export var speed = 360 
@export var margemErro = 67

@onready var bola = get_parent().get_node("Ball") 

func _physics_process(delta):
	if bola:
		var direcao = 0
		if bola.position.y > position.y + margemErro:
			direcao = 1
		elif bola.position.y < position.y - margemErro:
			direcao = -1
			
		var velocity = Vector2(0, direcao) * speed
		set_velocity(velocity)
		move_and_slide()

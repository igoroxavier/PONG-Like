extends RigidBody2D

var velocidade: Vector2

@onready var player_1_label = $"../player1_label"
@onready var player_2_label = $"../player2_label"
@onready var vitoria_label = $"../vitoria_label"

func _ready() -> void:
	randomize()
	atualizar_placar() 
	var angle = randf_range(-PI/6, PI/6)
	velocidade = Vector2(-200, 0).rotated(angle)

func reset_ball_position() -> void:
	self.position = get_window().size / 2
	var angle = randf_range(-PI/6, PI/6)
	var direcao = 1 if randf() > 0.5 else -1
	velocidade = Vector2(200 * direcao, 0).rotated(angle)

func _process(delta: float) -> void:
	if position.x < 0:
		GameController.player2_points += 1
		atualizar_placar()
		reset_ball_position()
	if position.x > get_window().size.x:
		GameController.player1_points += 1
		atualizar_placar()
		reset_ball_position()
	var collision = move_and_collide(velocidade * delta)
	if collision:
		velocidade = velocidade.bounce(collision.get_normal())
		velocidade *= 1.05
		if abs(velocidade.y) < 50:
			velocidade.y = 50 if velocidade.y > 0 else -50
			if velocidade.y == 0:
				velocidade.y = 50

func atualizar_placar() -> void:
	if player_1_label:
		player_1_label.text = "PLAYER 1: " + str(GameController.player1_points)
	if player_2_label:
		player_2_label.text = "PLAYER 2: " + str(GameController.player2_points)
	if GameController.player1_points >= 10:
		finalizar_jogo("JOGADOR 1 VENCEU")
	elif GameController.player2_points >= 10:
		finalizar_jogo("JOGADOR 2 VENCEU")
		
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		GameController.player1_points = 0
		GameController.player2_points = 0
		get_tree().reload_current_scene()

func finalizar_jogo(mensagem: String) -> void:
	get_tree().paused = true
	vitoria_label.text = mensagem 
	
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body == self:
		velocidade.y = -velocidade.y
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		velocidade.y = -velocidade.y

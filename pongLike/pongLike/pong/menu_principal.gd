extends Control


const CENA_DO_JOGO = "res://fase1.tscn" 

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
			iniciar_jogo()

func iniciar_jogo() -> void:
	GameController.player1_points = 0
	GameController.player2_points = 0
	

	get_tree().change_scene_to_file(CENA_DO_JOGO)

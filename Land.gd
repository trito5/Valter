extends Area2D

func _on_Land_body_entered(val):
	if val.name == "Groda" or val.name == "Groda2" or val.name == "Froggy" or val.name == "Froggy2" or val.name == "Froggy3":
		return
	$Hit.play()
	val.onLand(true)

func _on_Land_body_exited(val):
	if val.name == "Groda" or val.name == "Groda2" or val.name == "Froggy" or val.name == "Froggy2" or val.name == "Froggy3":
		return
	val.onLand(false)


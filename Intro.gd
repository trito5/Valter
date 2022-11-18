extends Node2D

var start = true
var toggleOnStart = false
	

func _process(delta):
	
	if Input.is_action_just_pressed("start"):
		if start:
			$Training.visible = true
			$Start.visible = false
			$StartText.visible = false
			start = false
			
		else:
			if toggleOnStart:
				get_tree().change_scene("res://World.tscn")

func toggleOnStart():
	toggleOnStart = true
	

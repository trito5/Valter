extends Node2D


func _ready():
	AudioManager.loadAudios(["happy_song"], "", {"loop":true, "trim":true})
	AudioManager.play("happy_song", {"loop":true})


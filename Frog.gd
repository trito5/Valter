extends KinematicBody2D


func _on_Area2D_body_entered(val):
	val.insta_friend()

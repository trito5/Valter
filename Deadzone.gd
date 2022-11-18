extends Area2D


func _on_DeadZone_body_entered(val):
	val.insta_dead()

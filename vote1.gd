extends Area2D


func _on_vote1_body_entered(val):
	val.take1()
	self.queue_free()

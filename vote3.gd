extends Area2D


func _on_vote3_body_entered(val):
	val.take3()
	self.queue_free()


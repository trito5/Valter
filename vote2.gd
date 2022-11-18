extends Area2D


func _on_vote2_body_entered(val):
	val.take2()
	self.queue_free()

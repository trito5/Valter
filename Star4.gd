extends Area2D



func _on_Star1_body_entered(body):
	body.star(4)
	queue_free()


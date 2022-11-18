extends Area2D

signal vector_created(vector)

export var maximum_length := 500

var touch_down := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO
var vector := Vector2.ZERO


func _ready() -> void:
	
	connect("input_event", self, "_on_input_event")


func _draw() -> void:
	
	draw_line(position_start - global_position,
	position_end - global_position,
	Color.red,
	8)
	
	draw_line(position_start - global_position,
	position_start - global_position + vector,
	Color.blue,
	8)
	
func _reset() -> void:
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	
	update()

func _input(event) -> void:
	
	if not touch_down:
		return
		
	
	if event.is_action_released("click"):
		touch_down = false
		vector.y = vector.y * 1.4
	
		vector.x = vector.x * 0.8
			
		emit_signal("vector_created", vector)
		_reset()
		
		
	if event is InputEventMouseMotion:
		position_end = get_global_mouse_position()
		vector = -(position_end - position_start).clamped(maximum_length)
		update()


func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("click"):
		touch_down = true
		position_start = get_global_mouse_position()
	

func _on_Area2D_body_entered(val):
	val.onWater(true)


func _on_Area2D_body_exited(val):
	val.onWater(false)

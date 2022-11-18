extends RigidBody2D

var onWater = true
var start = true
var jump = false
var dash = false


func _ready():
	set_bounce(0.3)
	set_friction(0.2)

func launch(force : Vector2) -> void:
	
		
	$Jump.play()
	
	apply_impulse(Vector2.ZERO, force)
	if force.x < 0:
		$AnimatedVal.scale = Vector2(-1,1)
		$Spray.global_position.x = $AnimatedVal.global_position.x -10
	else:
		$AnimatedVal.scale = Vector2(1,1)
		$Spray.global_position.x = $AnimatedVal.global_position.x + 10
	if not jump:
		jump = true	
		get_tree().get_root().get_node("Intro").get_node("Training").get_node("Box3").visible = true
	
func _physics_process(delta):
		
	if Input.is_action_just_pressed("spray"):
		$Dash.play()
		$Spray.visible = true
		apply_impulse(Vector2.ZERO, Vector2(0, 600))
	if Input.is_action_just_released("spray"):
		if not dash:
			dash = true
			get_tree().get_root().get_node("Intro").get_node("Training").get_node("Box4").visible = true
		$Spray.visible = false
	if dash and jump:
		get_tree().get_root().get_node("Intro").get_node("StartText").visible = true
		get_tree().get_root().get_node("Intro").toggleOnStart()
	
func onWater(boolean):
	
	onWater = boolean

	if onWater:
		if not start:
			$Splash.play()
			$AnimatedVal.play("splash")
		else:
			start = false
	else:
		$AnimatedVal.play("fly")


func _on_AnimatedVal_animation_finished():
		$AnimatedVal.play("chill") 
		

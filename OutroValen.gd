extends RigidBody2D

var onWater = true
var start = true
var jump = false
var dash = false
var time 
var death
var counter = 0

func _ready():
	set_bounce(0.3)
	set_friction(0.2)
	time = get_tree().get_root().get_node("Global").time
	death = get_tree().get_root().get_node("Global").death
	get_parent().get_node("Text").text = "Latest run"
	get_parent().get_node("Text1").text = "time: " + str(time) + ", death: " + str(death)
	


func launch(force : Vector2) -> void:
	
		
	$Jump.play()
	
	apply_impulse(Vector2.ZERO, force)
	if force.x < 0:
		$AnimatedVal.scale = Vector2(-1,1)
		$Spray.global_position.x = $AnimatedVal.global_position.x -10
	else:
		$AnimatedVal.scale = Vector2(1,1)
		$Spray.global_position.x = $AnimatedVal.global_position.x + 10

	
func _physics_process(delta):
		
	if Input.is_action_just_pressed("spray"):
		$Dash.play()
		$Spray.visible = true
		apply_impulse(Vector2.ZERO, Vector2(0, 600))
	if Input.is_action_just_released("spray"):
		$Spray.visible = false
		
	if Input.is_action_just_released("start"):
		get_tree().change_scene("res://Intro.tscn")

func star(num):
	$AnimatedVal.play("smile")
	counter = counter + 1
	$Count.text = "Stars: " + str(counter)
	if num == 1:
		$Star.play()
	elif num == 2:
		$Star2.play()
	elif num == 3:
		$Star3.play()
	elif num == 4:
		$Star4.play()
	elif num == 5:
		$Star5.play()
	elif num == 6:
		$Star6.play()
	elif num == 7:
		$Star7.play()
	elif num == 8:
		$Star8.play()
	
func onWater(boolean):
	print(boolean)
	onWater = boolean

	if onWater:
		$Splash.play()
		$AnimatedVal.play("splash")
		
	else:
		$AnimatedVal.play("fly")


func _on_AnimatedVal_animation_finished():
		$AnimatedVal.play("chill") 
		

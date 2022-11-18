extends RigidBody2D

var onLand = false
var onWater = true
var gameOver = false
var startPos
var start = true
var deadPos
var votes = 0
var noOfDeath = 0
var win = false

func _ready():
	set_bounce(0.3)
	set_friction(0.2)
	startPos = self.global_position
	print(startPos)
	
	

func launch(force : Vector2) -> void:
	if gameOver or win:
		return
	
	$Jump.play()
	
	apply_impulse(Vector2.ZERO, force)
	if force.x < 0:
		$AnimatedVal.scale = Vector2(-1,1)
		$Spray.global_position.x = $AnimatedVal.global_position.x -10
	else:
		$AnimatedVal.scale = Vector2(1,1)
		$Spray.global_position.x = $AnimatedVal.global_position.x + 10

func _physics_process(delta):
	if win and Input.is_action_just_pressed("reset"):
		hardReset()
	
	if win and Input.is_action_just_pressed("bonus"):
		get_tree().change_scene("res://Outro.tscn")
	
	if not gameOver and Input.is_action_just_pressed("spray"):
		$Dash.play()
		$Spray.visible = true
		apply_impulse(Vector2.ZERO, Vector2(0, 600))
	if not gameOver and Input.is_action_just_released("spray"):
		$Spray.visible = false
	if onLand and self.linear_velocity.x < 1 and self.linear_velocity.x > -1:
		hurt()
		onLand = false
	var pos = str(int(self.linear_velocity.x)) + ". " + str(int(self.linear_velocity.y))
	var timer = 100000 - int($CourseTimer.get_time_left())
	$TextEdit.set_text(str(timer))
	
	if gameOver:
		self.global_position = deadPos

	
func onLand(boolean):
	if boolean:
		onLand = true
	else: 
		onLand = false

func insta_friend():
	if not gameOver:
		$Explode.play()
		$AnimatedVal.play("ouch")
		$GameOverAkta.visible = true
		dead()
		
func insta_dead():
	if not gameOver:
		$Explode.play()
		$AnimatedVal.play("ouch")
		$GameOverOuch.visible = true
		dead()

func hurt():
	if not gameOver:
		$GameOverSign.visible = true
		$AnimatedVal.play("tear")
		dead()
	
func dead():
	gameOver = true
	$Timer.start()
	get_tree().get_root().get_node("World").get_node("Music").stop()
	$GameOver.play()
	deadPos = self.global_position
	noOfDeath = noOfDeath + 1
	
	
func onWater(boolean):
	onWater = boolean
	if gameOver:
		$AnimatedVal.play("tear")
	elif (onWater):
		if not start:
			$Splash.play()
			$AnimatedVal.play("splash")
		else:
			start = false
	else:
		$AnimatedVal.play("fly")
			
func reset():
	onLand = false
	onWater = true
	gameOver = false
	$AnimatedVal.play("chill")
	$GameOverSign.visible = false
	$GameOverAkta.visible = false
	$GameOverOuch.visible = false
	$NotWin.visible = false
	$Bbonus.visible = false
	$WinText.visible = true
	
	start = true
	self.global_position = startPos
	$Spray.visible = false
	get_tree().get_root().get_node("World").get_node("Music").play()
	$Win.stop()
	
func hardReset():
	reset()
	win = false
	noOfDeath = 0
	votes = 0
	$CourseCleared.visible = false
	$Vote1.visible = false
	$Vote2.visible = false
	$Vote3.visible = false
	$WinText.text = ""
	start = true
	self.global_position = startPos
	get_tree().change_scene("res://Intro.tscn")

func _on_Timer_timeout():
	reset()


func _on_AnimatedVal_animation_finished():
	if gameOver:
		$AnimatedVal.play("tear") 
	else:
		$AnimatedVal.play("chill") 
		
func win():
	if win:
		return
	if votes == 3:
		$Win.play()
		get_tree().get_root().get_node("World").get_node("Music").stop()
		win = true
		$CourseTimer.stop()
		$WinText.text = "Time: " + $TextEdit.text + ", deaths: " + str(noOfDeath)
		$CourseCleared.visible = true
		$WinText.visible = true
		$Bbonus.visible = true
		$Tid.visible = false
		$TextEdit.visible = false
		get_tree().get_root().get_node("Global").time = int($TextEdit.text)
		get_tree().get_root().get_node("Global").death = noOfDeath
	else:
		$NotWin.visible = true
		$NotWinTimer.start()

func take1():
	$Vote1.visible = true
	takeVote()

func take2():
	$Vote2.visible = true
	takeVote()

func take3():
	$Vote3.visible = true
	takeVote()
	
func takeVote():
	$Take.play()
	votes = votes + 1


func _on_NotWinTimer_timeout():
	$NotWin.visible = false

extends Control

export (PackedScene) var next_scene

onready var anim_player = get_node("anim_player")

var is_loading = true

func _ready():
	#enable user input
	set_process_input(true)
	
	#run animation
	fade_in_out()
	
func fade_in_out():
	anim_player.play("fade_in_out")
	anim_player.connect("finished",self, "go_to_next_scene")
	
func go_to_next_scene():
	if(is_loading):
		var timer = Timer.new()
		add_child(timer)
		timer.set_wait_time(1)
		timer.set_one_shot(false)
		timer.connect("timeout",self,"next_scene")
		timer.start()
	else:
			next_scene()

func next_scene():
	if(!is_loading):
		print("we are loading")
		
		#go to next scene
		get_parent().add_child(next_scene.instance())
		queue_free()

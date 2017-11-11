extends Control

export (PackedScene) var next_scene
var next_scene_instance = null

#loading thread
onready var loading_thread = Thread.new()

func _ready():
	#Begin loading data...
	loading_thread.start(self, "load_data")
	#Display the splash screen
	splash_screen()
	
func splash_screen():
	print("Load splash screen")
	
	#create and instance
	next_scene_instance = next_scene.instance()
	
	#add to scene
	add_child(next_scene_instance)
	
func load_data(vars):
	#similate data loading
	
	for i in range(0, 99000000):
		for i in range(0,7):
			pass
			
	print("done loading the data")
	next_scene_instance.is_loading = false
	
	

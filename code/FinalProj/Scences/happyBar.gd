extends Node2D

# bar values
var max_value = 100;
var current_value = 10;

# bar
onready var bar = get_node("bar")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func init(max_value, current_value):
	self.max_value = max_value * 1.0
	self.current_value = clamp(current_value * 1.0, 0, max_value)
	
	update()

#set current happy value
func set_bar(value):
	#set value of happy
	current_value = clamp(value, 0, max_value)
	#update happy bar
	update()
#reduce happy value
func reduce_bar():
	var value = current_value - 10
	#set value of happy
	current_value = clamp(value, 0, max_value)
	#update happy bar
	update()
	
func update():
	#calc health percentage (0-1)
	var percentage = current_value / max_value
	
	#update the health bar scale
	bar.set_scale(Vector2(percentage, 1))
	
	
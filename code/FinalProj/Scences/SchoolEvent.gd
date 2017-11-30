extends Control

#create object ref for the buttons
onready var option1 = get_node("VBox/option1")
onready var option2 = get_node("VBox/option2")
var val = null

func _ready():
	#connect a button press to a function
	option1.connect("button_down", self, "good")
	option2.connect("button_down", self, "bad")
	pass
func good():
	val = 1
	self.hide()
func bad():
	val = 0
	self.hide()
func getChoice():
	return val

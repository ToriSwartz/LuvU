extends Control

#happy stats
export (int) var max_happy = 100
export (int) var happy = 50

#hunger stats
export (int) var max_hunger = 100
export (int) var hunger = 50

#energy stats
export (int) var max_energy = 100
export (int) var energy = 50


var timer = null;
var wait_time = 20.0

#create object refs for the stat bars
onready var happyBar = get_node("bars/happybar")
onready var hungerBar = get_node("bars/hungerbar")
onready var energyBar = get_node("bars/energybar")

#create object ref for the buttons
onready var feedButton = get_node("BottomMenu/Feed")
onready var playButton = get_node("BottomMenu/Tablet")
onready var sleepButton = get_node("BottomMenu/Sleep")
onready var schoolButton = get_node("BottomMenu/School")

#create object ref for fluffle
onready var fluffle = get_node("Node2D/Fluffle")

func _ready():
	#initalize happy bar
	happyBar.init(max_happy,happy)
	hungerBar.init(max_hunger, hunger)
	energyBar.init(max_energy, energy)
	

	
	#connect a button press to a function
	feedButton.connect("button_down", self, "food_button_down")
	playButton.connect("button_down", self, "play_button_down")
	sleepButton.connect("button_down", self, "sleep_button_down")
	schoolButton.connect("button_down", self, "school_button_down")
	
	
	# Timer that decreases stats every wait_time
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.set_wait_time(wait_time)
	timer.set_one_shot(false) #make sure it loops
	timer.start()

	
#implimentation of reducing stats
func _on_Timer_timeout():
	#make sure stat values are always > 0
	if happy > 0:
		happy = happy - 10
	if hunger > 0:
		hunger = hunger - 10
	if energy > 0:
		energy = energy - 10
	
	#call stat object and set value
	happyBar.set_bar(happy)
	hungerBar.set_bar(hunger)
	energyBar.set_bar(energy)
	
	#decide which animation to play
	idle()
	
#what happens when the sleep button is pressed
func sleep_button_down():
	
	#animation is triggered
	fluffle.play("sleeping")
	
	#the button is disabled so it cannot be pressed repeatedly
	sleepButton.set_disabled(true)
	
	happy = happy + 10
	if (happy > 100):
		happy = 100
	energy = energy + 50
	if (energy > 100):
		energy = 100
	
	#modify the value
	happyBar.set_bar(happy)
	energyBar.set_bar(energy)
	#when animation finish call another action
	#this is the line that causes non crashing errors :((
	fluffle.connect("finished",self,"sleeping_idle")

#what happens when the food button is pressed
func food_button_down():
	
	#animation trigger
	fluffle.play("eating")
	
	#the button is disabled so it cannot be pressed repeatedly
	feedButton.set_disabled(true)
	
	happy = happy + 10
	if (happy > 100):
		happy = 100
	hunger = hunger + 20
	if (hunger > 100):
		hunger = 100
		
	#modify the value
	happyBar.set_bar(happy)
	hungerBar.set_bar(hunger)
	
	#when animation finish call another action
	fluffle.connect("finished",self,"eating_idle")

#what happens when the play button is pressed	
func play_button_down():
	
	#animation trigger
	fluffle.play("tablet")
	
	#the button is disabled so it cannot be pressed repeatedly
	playButton.set_disabled(true)
	happy = happy + 30
	if (happy > 100):
		happy = 100
		
	happyBar.set_bar(happy)
	
	#when animation finish call another action
	fluffle.connect("finished",self,"play_idle")

func school_button_down():
	get_node("SchoolEvent").show()
	get_node("SchoolEvent").connect("hide",self,"decideOutcome")

func decideOutcome():
	var choice = get_node("SchoolEvent").getChoice()
	if choice == 1:
		happyBar.set_bar(100)
		happy = 100
		idle()
	else:
		happyBar.set_bar(0)
		happy = 0
		idle()
	
	#all the functions below set animations
func eating_idle():
	idle()
	feedButton.set_disabled(false)
	
func play_idle():
	idle()
	playButton.set_disabled(false)
	
func sleeping_idle():
	idle()
	sleepButton.set_disabled(false)
	
func idle():
	if happy < 50:
		fluffle.play("mad")
	else:
		fluffle.play("default")
		
	
	
	
	
	
	
	
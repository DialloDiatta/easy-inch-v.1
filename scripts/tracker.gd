extends Control


@onready var timer: Timer = %Timer
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var total_completed: Label = %TotalCompleted
@onready var round_completed: Label = %RoundCompleted
@onready var round_tracker_container: VBoxContainer = %RoundTrackerContainer
@onready var pause_button: Button = $VBoxContainer/PauseButton
@onready var score_label: Label = %Score
@onready var vignette: Control = %Vignette
@onready var frame: CenterContainer = %Frame

@export var time_modifier: float = 1.0

var score: int = 0
var score_increment: int = 100

var completed: int = 0
var all_completed: int = 0
var round_count: int = 1

func _ready() -> void:
	SignalHandler.complete.connect(on_complete)
	SignalHandler.round_end.connect(on_round_end)
	SignalHandler.round_start.connect(reset)

func _process(delta: float) -> void:
	progress_bar.value = timer.time_left
	progress_bar.max_value = timer.wait_time

func on_complete():
	completed += 1
	all_completed += 1
	update_completed_label()
	add_points()
	# Handles increases in difficulty
	# TODO Check to see if this is running unecessary processes. 
	if all_completed == 20:
		timer.wait_time = 8
	if all_completed == 50:
		timer.wait_time = 5
	if all_completed == 80:
		timer.wait_time = 3
	if all_completed == 100:
		timer.wait_time = 2
	
	
	timer.start()
	
func update_completed_label():
	total_completed.text = str(all_completed)
	round_completed.text = str(completed)

func on_round_end():
	var new_entry = Label.new()
	new_entry.add_theme_font_size_override("font_size", 36)
	new_entry.text = "Round " + str(round_count) + " : " + str(completed)
	round_tracker_container.add_child(new_entry)
	
	# Scoring
	if score > global.high_score:
		global.high_score = score
		SignalHandler.new_highscore.emit()
	SignalHandler.finalize_score.emit(score)
	# THEN
	round_count += 1
	completed = 0
	round_completed.text = str(completed)
	
	

func _on_timer_timeout() -> void:
	SignalHandler.round_end.emit()
	


func _on_pause_button_toggled(toggled_on: bool) -> void:
	timer.paused = toggled_on
	if toggled_on:
		pause_button.text = "START"
	else: 
		pause_button.text = "PAUSE TIMER"

func add_points(): # Might want to put this in it's own scripts.
	var new_score = get_new_score()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_method(set_label_text, score, new_score, 0.5)
	tween.finished.connect(func(): score = new_score)
	
func get_new_score():
	var new_score: float = score + (
		get_efficiency_bonus()*(score_increment * get_time_modifier())
		)
	return new_score
	
func get_time_modifier():
	# I can fill this area with all sorts of different modifiers
	# based on how much time is left. 
	if timer.time_left >= timer.wait_time / 2:
		return time_modifier # This can exist as a standalone float or export var.
	else:
		return 1.0

func set_label_text(value: int):
	score_label.text = str(value)

func _input(event: InputEvent) -> void: #TODO Get rid of this func.
	if Input.is_action_just_pressed("test"):
		get_efficiency_bonus()

func get_efficiency_bonus(): # Impressed I built this but I don't understand how it works fully. 
	var target = GoalManager.current_goal
	var efficiency_threshold = 0.0
	for n in [16, 8, 4, 2, 1]:
		if target >= n:
			target -= n
			efficiency_threshold += 1.0
			
	print("Efficiency Threshold: ", efficiency_threshold)
	# The board is clearing before get_active_buttons() can run. 
	if frame.get_active_buttons() > efficiency_threshold: 
		return 1.0
	else:
		return 2.0

func reset():
	score = 0
	timer.start()
	timer.wait_time = 10
	

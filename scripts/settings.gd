extends VBoxContainer

signal set_val(value: float, setting_id: String)

@onready var max_val: Label = $MaxVal
@onready var min_val: Label = $MinVal
@onready var max_slider: HSlider = $MaxSlider
@onready var min_slider: HSlider = $MinSlider

func _ready() -> void:
	max_val.text = str(max_slider.value)
	min_val.text = str(min_slider.value)

func _on_max_slider_value_changed(value: float) -> void:
	max_val.text = str(value)

func _on_min_slider_value_changed(value: float) -> void:
	min_val.text = str(value)
	
func _on_max_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		if !same_number_check():
			if max_slider.value == 1:
				correct_max_slider()
				correct_min_slider()
			elif max_slider.value <= min_slider.value:
				set_val.emit(max_slider.value, "max")
				correct_min_slider()
			else:
				set_val.emit(max_slider.value, "max")
		elif same_number_check():
			if min_slider.value <= 1:
				correct_max_slider()
			else:
				min_slider.value = max_slider.value - 1
			
func _on_min_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		if !same_number_check():
			if min_slider.value >= max_slider.value:
				# Below code can be replaced with correct_min_slider()
				# if we don't want the lowest to move the highest.
				max_slider.value = min_slider.value + 1
				set_val.emit(max_slider.value, "max")
				set_val.emit(max_slider.value, "max")
			else:
				set_val.emit(min_slider.value, "min")
		elif same_number_check():
			correct_min_slider()
		

func correct_max_slider():
	max_slider.value += 1
	set_val.emit(max_slider.value, "max")

func correct_min_slider():
	min_slider.value = max_slider.value - 1
	set_val.emit(max_slider.value, "max")

func same_number_check():
	if max_slider.value == min_slider.value:
		return true
	else:
		return false
# TODO Incorporate a popup when both numbers are the same and refuse
# continuation until it's changed. The game will crash if min and max
	# are equal.

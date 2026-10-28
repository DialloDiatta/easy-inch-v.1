extends Control

# TODO Change all these variable references to Unique name because if the scene tree changes all my code will be off. 
@onready var name_of_item: Label = $PopUp/Panel/Content/Panel/VBoxContainer/Interactables/VBoxContainer/HBoxContainer/VBoxContainer/NameOfItem
@onready var owned: Label = $PopUp/Panel/Content/Panel/VBoxContainer/Interactables/VBoxContainer/HBoxContainer/VBoxContainer/Owned
@onready var effect: Label = $PopUp/Panel/Content/Panel/VBoxContainer/Interactables/VBoxContainer/HBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/Effect
@onready var description: Label = $PopUp/Panel/Content/Panel/VBoxContainer/Interactables/VBoxContainer/HBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/Description
@onready var item_icon: TextureRect = $PopUp/Panel/Content/Panel/VBoxContainer/Interactables/VBoxContainer/HBoxContainer/ItemIcon
@onready var rarity_icon: TextureRect = $PopUp/Panel/Content/Panel/VBoxContainer/Interactables/VBoxContainer/HBoxContainer/ItemIcon/RarityIcon
@onready var b_w_icon: TextureRect = $"PopUp/Panel/Content/Panel/IconPositionHandler/B&WIcon"
@onready var item_category: Label = $PopUp/Panel/Category/ItemCategory

@onready var buttons_container: VBoxContainer = $PopUp/Panel/Content/Panel/VBoxContainer/Interactables/VBoxContainer/MarginContainer/ButtonsContainer
@onready var obtain_button_scene = preload("res://scenes/zzz_obtain_button.tscn")

func _ready() -> void:
	clear_buttons_container()

func _on_background_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self.queue_free()

func add_item(item: ItemData):
	name_of_item.text = str(item["name"])
	item_icon.texture = item["texture"]
	b_w_icon.texture = item["texture"]
	effect.text = str(item["effect"])
	description.text = str(item["description"])
	item_category.text = str(item["type"])
	rarity_icon.texture = get_rarity_icon(item.rarity)
	add_obtain_button(item)

func clear_buttons_container():
	while buttons_container.get_child_count() > 0:
		var child = buttons_container.get_child(0)
		buttons_container.remove_child(child)
		child.queue_free()

func add_obtain_button(item):
	var obtain_button = obtain_button_scene.instantiate()
	buttons_container.add_child(obtain_button)
	obtain_button.set_data(item)

func hide_button_container():
	buttons_container.visible = false

func get_rarity_icon(rarity: String):
	if rarity == "S":
		return preload("res://assets/Icons/s_rarity_icon.png")
	if rarity == "A":
		return preload("res://assets/Icons/a_rarity_icon.png")
	if rarity == "B":
		return preload("res://assets/Icons/b_rarity_icon.png")
	else:
		return Color.WHITE

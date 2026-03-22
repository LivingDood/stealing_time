extends Node

@export var play_button: Button
@export var level_menu: RightSideMenu

@export var options_button: Button
@export var options_menu: RightSideMenu

@export var animation_player: AnimationPlayer
@export var tree_area: Area2D
@export var tree_sprite: Sprite2D
@export var tree_marker: Marker2D
@export var character_marker: Marker2D
@export var steal_sfx: AudioStream

var _is_hovering_tree: bool = false


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	
	tree_area.mouse_entered.connect(_on_tree_area_mouse_entered)
	tree_area.mouse_exited.connect(_on_tree_area_mouse_exited)
	
	animation_player.play(&"character")
	play_button.grab_focus()


func _process(delta: float) -> void:
	if _is_hovering_tree:
		if Input.is_action_pressed("steal"):
			ParticleManager.generate(tree_marker.global_position, character_marker, steal_sfx)
			animation_player.advance(-3.0 * delta)


func toggle_level_menu() -> void:
	if level_menu.visible:
		level_menu.reset()
		return
	
	## Ensures the options menu is hidden before showing the level menu.
	if options_menu.visible:
		options_menu.reset()
	
	level_menu.display()


func toggle_options_menu() -> void:
	if options_menu.visible:
		options_menu.reset()
		return
	
	## Ensures the level menu is hidden before showing the options menu.
	if level_menu.visible:
		level_menu.reset()
	
	options_menu.display()


func _on_play_button_pressed() -> void:
	play_button.grab_focus()
	toggle_level_menu()


func _on_options_button_pressed() -> void:
	options_button.grab_focus()
	toggle_options_menu()


func _on_tree_area_mouse_entered() -> void:
	_is_hovering_tree = true
	tree_sprite.set_instance_shader_parameter("is_enabled", true)


func _on_tree_area_mouse_exited() -> void:
	_is_hovering_tree = false
	tree_sprite.set_instance_shader_parameter("is_enabled", false)

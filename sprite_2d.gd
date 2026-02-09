extends Sprite2D

var dodge_tween: Tween
@export var is_dodging: bool = false
@onready var particles = $GPUParticles2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_local_mouse_position()
	
	if get_rect().has_point(mouse_pos) and not is_dodging:
		dodge()

func dodge() -> void:
	is_dodging = true
	particles.emitting = true
	play_teleport_sound()
	
	if is_instance_valid(dodge_tween) and dodge_tween.is_running():
		dodge_tween.kill()
		
	dodge_tween = create_tween()
	dodge_tween.tween_property(self, "position", get_random_screen_position(), .001)
	dodge_tween.tween_callback(func(): is_dodging = false)
		
func get_random_screen_position() -> Vector2:
	return Vector2(
		randf_range(0.0, get_viewport_rect().size.x),
		randf_range(0.0, get_viewport_rect().size.y)
	)

func play_teleport_sound() -> void:
	audio_stream_player_2d.play()

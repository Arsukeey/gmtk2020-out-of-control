extends Node2D

signal turn

var can_move = true

func _process(delta):
    var sqr_size = get_parent().SQR_SIZE
    if can_move:
        if Input.is_action_pressed("ui_right"):
            position.x += sqr_size
        if Input.is_action_pressed("ui_left"):
            position.x -= sqr_size
        if Input.is_action_pressed("ui_up"):
            position.y -= sqr_size
        if Input.is_action_pressed("ui_down"):
            position.y += sqr_size
        emit_signal("turn")
        can_move = false

func _on_TimerSkip_timeout():
    emit_signal("turn")

func _on_TimerMoveDelay_timeout():
    can_move = true

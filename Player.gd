extends Node2D

signal turn

var can_move = true

var spell0 = null
var spell1 = null
var spell2 = null

func generate_random_attacks(): 
    var attacks = get_tree().get_nodes_in_group("attack")
    attacks.shuffle()
    spell0 = attacks[0]
    spell1 = attacks[1]
    spell2 = attacks[2]

func _ready():
    generate_random_attacks()
    pass

func _process(_delta):
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
        
        if Input.is_action_pressed("ui_right") or \
        Input.is_action_pressed("ui_left") or \
        Input.is_action_pressed("ui_up") or \
        Input.is_action_pressed("ui_down"):
            emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()
        draw_spell_on_menu()

func draw_spell_on_menu():
    spell1.visible = true
    spell1.get_node("Sprite").visible = false
    var spell1_node = spell1.get_node("Node2D")
    spell1_node.visible = true
    spell1_node.position = $CanvasLayer/SpellMenu/Spell1Menu.position

func _on_TimerSkip_timeout():
    emit_signal("turn")

func _on_TimerMoveDelay_timeout():
    can_move = true

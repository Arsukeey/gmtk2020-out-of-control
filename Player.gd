extends Node2D

signal turn

var hearts = 3
const HEART_SEPARATOR = 40
enum Direction {
    Right,
    Up,
    Down,
    Left,
}

var looking = Direction.Right
onready var sqr_size = get_parent().SQR_SIZE

var can_move = true

var spell0 = null
var spell1 = null
var spell2 = null

func generate_random_attacks(): 
    var attacks = get_tree().get_nodes_in_group("attack")
    attacks.shuffle()
    spell0 = attacks.pop_front()
    spell1 = attacks.pop_front()
    spell2 = attacks.pop_front()
    draw_hearts()

func _ready():
    randomize()
    generate_random_attacks()
    
    
func draw_hearts():
    for i in range(hearts):
        var heart = Sprite.new()
        heart.texture = preload("res://assets/heart.png")
        var pos = $CanvasLayer2/HeartPosition.position
        pos.x += i * 50 + HEART_SEPARATOR
        var a = Position2D.new()
        a.position = pos
        a.add_child(heart)
        $CanvasLayer2.add_child(a)

var last_move = 321321

func _process(_delta):
    if can_move:
        if Input.is_action_pressed("ui_right"):
            position.x += sqr_size
            
            if last_move == Direction.Right:
                last_move = 321321
                $PlayerSprite.play("side-walk")
            else:
                last_move = Direction.Right
                $PlayerSprite.play("side")
            looking = Direction.Right
            $PlayerSprite.flip_h = false
            emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()
        if Input.is_action_pressed("ui_left"):
            position.x -= sqr_size
            looking = Direction.Left
            if last_move == Direction.Left:
                last_move = 321321
                $PlayerSprite.play("side-walk")
            else:
                last_move = Direction.Left
                $PlayerSprite.play("side")
            $PlayerSprite.flip_h = true
            emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()
        if Input.is_action_pressed("ui_up"):
            looking = Direction.Up
            position.y -= sqr_size
            if last_move == Direction.Up:
                last_move = 321321
                $PlayerSprite.play("back-walk")
            else:
                last_move = Direction.Up
                $PlayerSprite.play("back")
                emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()
            $PlayerSprite.flip_h = false
        if Input.is_action_pressed("ui_down"):
            looking = Direction.Down
            if last_move == Direction.Down:
                last_move = 321321
                $PlayerSprite.play("front-walk")
            else:
                last_move = Direction.Down
                $PlayerSprite.play("front")
            position.y += sqr_size
            $PlayerSprite.flip_h = false
            emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()
            
        # attack
        draw_spell_on_menu()
        if Input.is_action_just_pressed("attack0"):
            spell0.attack(get_parent().enemies, Vector2(position.x / sqr_size, position.y / sqr_size), looking)
            emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()
        if Input.is_action_just_pressed("attack1"):
            spell1.attack(get_parent().enemies, Vector2(position.x / sqr_size, position.y / sqr_size), looking)
            emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()
        if Input.is_action_just_pressed("attack2"):
            spell2.attack(get_parent().enemies, Vector2(position.x / sqr_size, position.y / sqr_size), looking)
            emit_signal("turn")
            can_move = false
            $TimerMoveDelay.start()

func draw_spell_on_menu():
    $CanvasLayer/SpellMenu/Spell1Menu/CurrentSpell.texture = spell0.get_node("Node2D/Icon").texture
    $CanvasLayer/SpellMenu/Spell2Menu/CurrentSpell.texture = spell1.get_node("Node2D/Icon").texture
    $CanvasLayer/SpellMenu/Spell3Menu/CurrentSpell.texture = spell2.get_node("Node2D/Icon").texture

func _on_TimerMoveDelay_timeout():
    can_move = true

func _on_World_player_hurt():
    $CanvasLayer2.get_child(hearts).queue_free()
    hearts -= 1
    if hearts == 0:
        get_parent().game_over()

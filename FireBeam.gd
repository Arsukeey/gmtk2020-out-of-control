extends Node2D

const DAMAGE = 15

func attack(grid, ppos, look_dir):
    print("firebeam")
    for i in grid.pos.size():
        if grid.pos[i].y == ppos.y:
            grid.objs[i].take_damage(DAMAGE)

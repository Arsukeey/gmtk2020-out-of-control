extends Node2D

const DAMAGE = 10

func attack(grid, ppos):
    print("firebeam")
    for i in grid[ppos.x / get_parent().sqr_size]:
        if i.get_type() == Node2D:
            i.take_damage(DAMAGE)

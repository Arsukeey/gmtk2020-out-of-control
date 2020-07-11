extends Node2D

const DAMAGE = 10

func attack(grid, ppos):
    print("firebeam")
    for i in grid[ppos.y]:
        if i.is_in_group("enemy"):
            i.take_damage(DAMAGE)

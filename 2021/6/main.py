with open("2021/6/input.txt") as f:
    input = [int(num) for num in f.readlines()[0].split(",")]

def part1():
    fish_counts: dict[int, int] = {k: input.count(k) for k in input}

    for day in range(80):
        new_day = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0}

        for k, v in fish_counts.items():
            if k == 0:
                new_day[6] += v
                new_day[8] += v
            else:
                new_day[k - 1] += v

        for k, v in new_day.items():
            fish_counts[k] = v

    return sum(fish_counts.values())

def part2():
    fish_counts: dict[int, int] = {k: input.count(k) for k in input}

    for day in range(256):
        new_day = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0}

        for k, v in fish_counts.items():
            if k == 0:
                new_day[6] += v
                new_day[8] += v
            else:
                new_day[k - 1] += v

        for k, v in new_day.items():
            fish_counts[k] = v

    return sum(fish_counts.values())

print(part1())
print(part2())

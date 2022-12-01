with open("2021/5/input.txt") as f:
    lines: list[tuple[tuple[int, int], tuple[int, int]]] = []

    for line in f.readlines():
        a, b = line.split("->")
        x1, y1 = [int(z1) for z1 in a.split(",")]
        x2, y2 = [int(z2) for z2 in b.split(",")]
        lines.append(((x1, y1), (x2, y2)))

def get_nums(start: int, end: int) -> range:
    mod = 1 if start < end else -1
    return range(start, end + mod, mod)

def get_diagonal_numbers(x1: int, y1: int, x2: int, y2: int) -> list[tuple[int, int]]:
    nums: list[tuple[int, int]] = []

    for x in get_nums(x1, x2):
        m = (y1 - y2) / (x1 - x2)
        c = y1 - (m * x1)
        y = (m * x) + c

        nums.append((x, int(y)))

    return nums

def part1():
    filtered = [line for line in lines if (line[0][0] == line[1][0] or line[0][1] == line[1][1])]
    max_width = max([max(line[0][0], line[1][0]) for line in filtered])
    max_height = max([max(line[0][1], line[1][1]) for line in filtered])

    board = [[0 for _ in range(max_width + 1)] for _ in range(max_height + 1)]

    for line in filtered:
        x1, y1 = line[0]
        x2, y2 = line[1]

        if x1 != x2:
            for x in get_nums(x1, x2):
                board[y1][x] += 1

        if y1 != y2:
            for y in get_nums(y1, y2):
                board[y][x1] += 1

    total = 0

    for row in board:
        for item in row:
            if item >= 2:
                total += 1

    return total

def part2():
    max_width = max([max(line[0][0], line[1][0]) for line in lines])
    max_height = max([max(line[0][1], line[1][1]) for line in lines])
    board = [[0 for _ in range(max_width + 1)] for _ in range(max_height + 1)]

    for line in lines:
        x1, y1 = line[0]
        x2, y2 = line[1]

        if x1 != x2 and y1 != y2:
            for x, y in get_diagonal_numbers(x1, y1, x2, y2):
                print(x, y)
                board[y][x] += 1

        elif x1 != x2:
            for x in get_nums(x1, x2):
                board[y1][x] += 1

        elif y1 != y2:
            for y in get_nums(y1, y2):
                board[y][x1] += 1

    total = 0

    for row in board:
        for item in row:
            if item >= 2:
                total += 1

    return total

# print(part1())
print(part2())

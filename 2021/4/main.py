from copy import deepcopy

with open("2021/4/input.txt") as f:
    input = [line.strip("\n") for line in f.readlines()]
    numbers = [int(num) for num in input[0].split(",")]
    boards: list[list[list[list]]] = []
    for line in input[1:]:
        if line == "":
            boards.append([])
        else:
            boards[-1].append([[int(num.strip()), False] for num in line.split()])

    input_1 = deepcopy(boards)
    input_2 = deepcopy(boards)

def get_total(board: list[list[list]]) -> int:
    total = 0

    for row in board:
        print(row)
        for item in row:
            if not item[1]:
                total += item[0]

    return total

def part1():
    for number in numbers:
        for board in input_1:
            for row in board:
                for item in row:
                    if item[0] == number:
                        item[1] = True

        for board in input_1:
            for row in [*board, *zip(*board)]:
                if all(item[1] for item in row):
                    return get_total(board) * number

def part2():
    found: list[list] = []

    for number in numbers:
        for board in input_2:
            for row in board:
                for item in row:
                    if item[0] == number:
                        item[1] = True

        for i, board in enumerate(input_2):
            if i in [f[0] for f in found]:
                continue

            for row in [*board, *zip(*board)]:
                if all(item[1] for item in row):
                    found.append([i, number, deepcopy(board)])


    return get_total(found[-1][2]) * found[-1][1]


print(part1())
print(part2())

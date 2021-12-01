with open("2021/1/input.txt") as f:
    input = [int(depth) for depth in f]

def part1():
    inc = 0
    last = input[0]

    for depth in input[1:]:
        if depth > last:
            inc += 1
        last = depth

    return inc

def part2():
    inc = 0
    last = input[0]

    for i in range(1, len(input) - 2):
        window = sum(input[i:i+3])

        if window > last:
            inc += 1

        last = window

    return inc

print(part1())
print(part2())

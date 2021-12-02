with open("2021/2/input.txt") as f:
    input = f.read().splitlines()

def part1():
    hor = 0
    depth = 0

    for command, amount in [line.split(" ") for line in input]:
        amount = int(amount)

        if command == "forward":
            hor += amount
        elif command == "down":
            depth += amount
        elif command == "up":
            depth -= amount

    return hor * depth

def part2():
    aim = 0
    hor = 0
    depth = 0

    for command, amount in [line.split(" ") for line in input]:
        amount = int(amount)

        if command == "forward":
            depth += aim * amount
            hor += amount
        elif command == "down":
            aim += amount
        elif command == "up":
            aim -= amount

    return hor * depth

print(part1())
print(part2())

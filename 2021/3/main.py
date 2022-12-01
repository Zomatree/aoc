with open("2021/3/input.txt") as f:
    input = f.read().splitlines()

def part1():
    gamma_bits = []

    for bits in zip(*input):
        gamma_bits.append(int(bits.count("1") > bits.count("0")))

    gamma = int(''.join(map(str, gamma_bits)), 2)

    return gamma * (~gamma & 0b111111111111)

def part2():
    values = input.copy()
    oxy = 0
    c02 = 0

    for i in range(12):
        bits = [line[i] for line in values]

        if bits.count("1") >= bits.count("0"):
            bit = "1"
        else:
            bit = "0"

        values = list(filter(lambda line: line[i] == bit, values))

        if len(values) == 1:
            oxy = int(values[0], 2)
            break

    values = input.copy()

    for i in range(12):
        bits = [line[i] for line in values]

        if bits.count("0") > bits.count("1"):
            bit = "1"
        else:
            bit = "0"

        values = list(filter(lambda line: line[i] == bit, values))

        if len(values) == 1:
            c02 = int(values[0], 2)
            break

    return oxy * c02

print(part1())
print(part2())

#! /usr/local/bin/python3.10

import sys
import pathlib
import requests
import toml

with open("config.toml") as f:
    config = toml.load(f)

year = sys.argv[1]
day = sys.argv[2]

path = pathlib.Path.cwd() / year / day
path.mkdir()

input_file = path / "input.txt"
input = requests.get(f"http6s://adventofcode.com/{year}/day/{day}/input", cookies=config["cookies"]).text
input_file.write_text(input)

main_file = path / "main.py"
main_file.write_text(config["template"].format(year=year, day=day))

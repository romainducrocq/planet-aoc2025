## Advent of Code 2025 with planet

[planet](https://github.com/romainducrocq/planet) is a C-like programming language based on my C compiler [wheelcc](https://github.com/romainducrocq/wheelcc), written in C from scratch for Linux and MacOS. It compiles programs to native x86-64 assembly and uses the C standard library at runtime. I'm using Advent of Code as a fun way to test my language on different sorts of problems.  
<!---->
Here are the solutions for AOC 2025 in `planet`!  

### Quick install

See the repo of the language for more info, or get started now:  
```
git clone --depth 1 --branch master --recurse-submodules --shallow-submodules https://github.com/romainducrocq/planet
cd planet/bin/
./configure.sh
./make.sh
./install.sh
. ~/.bashrc # or . ~/.zshrc
```

### Run AOC 2025

1. Add your inputs with `input/day00.txt`, from `01` to `12`.
2. Build and run
- the solution for a specific day:  
```
./build_and_run.sh --no-check [1-12]
```
- or all solutions for AOC 2025:  
```
./build_and_run.sh --no-check
```
(Running without `--no-check` tests against my own answers.)  

****

@romainducrocq

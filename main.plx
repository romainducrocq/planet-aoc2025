import `libutil`

############
# AOC 2025 #
############

extrn fn puts(s: string) i32;
pub fn print_i64(n: i64) i32 {
    extrn fn printf(format: string, n: i64) i32;
    return printf("%li", n)
}
pub fn snprint_i64(str: string, size: u64, n: i64) i32 {
    extrn fn snprintf(str: string, size: u64, format: string, n: i64) i32;
    return snprintf(str, size, "%li", n)
}

# stdlib.h
extrn fn exit(status: i32) none;

# string.h
extrn fn strlen(s: string) u64;
extrn fn strcpy(dst: string, src: string) *char;

# TODO replace with isdigit and strtol

pub fn is_digit(c: char) i32 {
    return '0' <= c and c <= '9'
}

pub fn parse_number(str: *string) i64 {
    sign: i32 = 1
    if str[][] == '-' {
        sign = -1
        (str[])++
    }
    value: i64 = 0
    loop while is_digit(str[][]) .. ++(str[]) {
        value = 10 * value + str[][] - '0'
    }
    return sign * value
}

###############
# Entry Point #
###############

extrn fn part_1(none) i64;
extrn fn part_2(none) i64;

pub input: struc FileText = $(nil)

answers: [12][2]i64 = $(
    $(1147, 6789),                    # day 1
    $(8576933996, 25663320831),       # day 2
    $(17301, 172162399742349),        # day 3
    $(1460, 9243),                    # day 4
    $(681, 348820208020395),          # day 5
    $(6172481852142, 10188206723429), # day 6
    $(0, 0) # day 7
)

fn check_answer(part: i64, answer: i64) none {
    print_i64(part)
    if part ~= answer {
        puts(" - Wrong answer")
        ftext_close(@input)
        exit(1)
    }
    puts(" - OK")
}

pub fn main(_: i32, args: *string) i32 {
    num: *char = @args[0][strlen(args[0])-2]
    filename: [16]char = $(nil)
    strcpy(filename, "input/day00.txt")
    filename[9] = num[0]
    filename[10] = num[1]
    day: i32 = parse_number(@num)-1

    ftext_read(filename, @input)
    check_answer(part_1(), answers[day][0])
    check_answer(part_2(), answers[day][1])
    ftext_close(@input)

    return 0
}

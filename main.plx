import `libinput`
use `stdio`
use `stdlib`
use `string`

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
    $(1660, 305999729392659),         # day 7
    $(50760, 3206508875),             # day 8
    $(4750176210, 1574684850),        # day 9
    $(514, 21824),                    # day 10
    $(688, 293263494406608),          # day 11
    $(0, 0)                           # day 12
)

fn check_answer(part: i64, answer: i64) none {
    s: [32]char = $(nil)
    print(ltostr(s, part))
    if part ~= answer {
        puts(" - Wrong answer")
        ftext_close(@input)
        exit(1)
    }
    puts(" - OK")
}

pub fn main(_: i32, args: *string) i32 {
    num: *char = @args[0][strlen(args[0])-2]
    day: i32 = strtol(num, nil, 10)-1
    filename: [32]char = $(nil)
    snprint(filename, 16, fmt3("input/day", num, ".txt"))

    if (ftext_read(filename, @input)) {
        fprint(get_stderr(), fmt3("Cannot open file ", filename, "\n"))
        abort()
    }
    check_answer(part_1(), answers[day][0])
    check_answer(part_2(), answers[day][1])
    ftext_close(@input)

    return 0
}

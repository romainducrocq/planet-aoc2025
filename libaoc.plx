import `libaoc`

############
# AOC 2025 #
############

# malloc.h
extrn fn malloc(size: u64) *any;
extrn fn free(ptr: *any) none;

# stdio.h
type struc FILE;
pub SEEK_SET: i32 = 0
pub SEEK_END: i32 = 2

extrn fn fopen(pathname: string, mode: string) *struc FILE;
extrn fn fread(ptr: *any, size: u64, nmemb: u64, stream: *struc FILE) u64;
extrn fn fseek(stream: *struc FILE, offset: i64, whence: i32) i32;
extrn fn ftell(stream: *struc FILE) i64;
extrn fn fclose(stream: *struc FILE) i32;

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
extrn fn strcpy(dst: string, src: string) string;

#############
# File Data #
#############

# TODO fix memory leak

pub fn read_file(filename: string, filedata: *struc FileData) none {
    filedata[].size = 0
    filedata[].maxlen = 0
    file: *struc FILE = fopen(filename, "r")
    if file == nil {
        puts("Cannot open file")
        puts(filename)
        exit(1)
    }
    fseek(file, 0, SEEK_END)
    len: i32 = ftell(file)
    fseek(file, 0, SEEK_SET)
    buf: string = cast<string>(malloc(sizeof<char> * len + 1))
    fread(buf, 1, len, file)
    fclose(file)
    buf[len] = nil
    loop i: i32 = 0 while i < len .. ++i {
        if buf[i] == '\n' {
            filedata[].size++
        }
    }
    filedata[].buf = cast<*string>(malloc(filedata[].size * sizeof<string>))
    str: string = buf
    loop i: i32 = 0 while i < filedata[].size .. ++i {
        filedata[].buf[i] = str
        j: i32 = 0
        loop while str[] ~= '\n' {
            if str[] == '\r' {
                str[] = nil
            }
            else {
                j++
            }
            str++
        }
        if j > filedata[].maxlen {
            filedata[].maxlen = j
        }
        str++[] = nil
    }
    # free(buf)
}

pub fn close_file(filedata: *struc FileData) none {
    ; # free(filedata[].buf)
}

##############
# Common Lib #
##############

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

pub filedata: struc FileData = $(nil)

answers: [12][2]i64 = $(
    $(1147, 6789),             # day 1
    $(8576933996, 25663320831) # day 2
)

fn get_input(day: i32) *char {
    match day {
        -> 1 { return "input/day01.txt" }
        -> 2 { return "input/day02.txt" }
        otherwise { return "" }
    }
}

fn check_answer(part: i64, answer: i64) none {
    print_i64(part)
    if part ~= answer {
        puts(" - Wrong answer")
        close_file(@filedata)
        exit(1)
    }
    puts(" - OK")
}

pub fn main(_: i32, args: *string) i32 {
    len: u64 = strlen(args[0])
    day: i32 = args[0][len-1] - '0'
    if args[0][len-2] == '1' { day += 10 }

    read_file(get_input(day), @filedata)
    check_answer(part_1(), answers[day-1][0])
    check_answer(part_2(), answers[day-1][1])
    close_file(@filedata)

    return 0
}

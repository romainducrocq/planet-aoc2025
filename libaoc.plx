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
extrn fn strcpy(dst: string, src: string) *char;

#############
# File Data #
#############

pub fn fclose_text(filetext: *struc FileText) none {
    filetext[].lines = 0
    filetext[].width = 0
    if filetext[].text {
        free(filetext[].text)
        filetext[].text = nil
    }
    if filetext[].buf {
        free(filetext[].buf)
        filetext[].buf = nil
    }
}

pub fn fread_text(filename: string, filetext: *struc FileText) none {
    fclose_text(filetext)
    file: *struc FILE = fopen(filename, "r")
    if file == nil {
        puts("Cannot open file")
        puts(filename)
        exit(1)
    }
    fseek(file, 0, SEEK_END)
    len: i32 = ftell(file)
    fseek(file, 0, SEEK_SET)
    filetext[].buf = cast<string>(malloc(sizeof<char> * len + 1))
    fread(filetext[].buf, 1, len, file)
    fclose(file)
    filetext[].buf[len] = nil
    loop i: i32 = 0 while i < len .. ++i {
        if filetext[].buf[i] == '\n' {
            filetext[].lines++
        }
    }
    filetext[].text = cast<*string>(malloc(filetext[].lines * sizeof<string>))
    str: string = filetext[].buf
    loop i: i32 = 0 while i < filetext[].lines .. ++i {
        filetext[].text[i] = str
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
        if j > filetext[].width {
            filetext[].width = j
        }
        str++[] = nil
    }
}

pub fn dd(i: i32, j: i32, filetext: *struc FileText) char {
    return ? (
        i >= 0 and i < filetext[].lines and j >= 0 and j < filetext[].width
    ) then filetext[].text[i][j] else ' '
}

##############
# Common Lib #
##############

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
    $(1147, 6789),              # day 1
    $(8576933996, 25663320831), # day 2
    $(17301, 172162399742349),  # day 3
    $(1460, 9243),              # day 4
    $(681, 348820208020395),    # day 5
    $(0, 0)                     # day 6
)

fn check_answer(part: i64, answer: i64) none {
    print_i64(part)
    if part ~= answer {
        puts(" - Wrong answer")
        fclose_text(@input)
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

    fread_text(filename, @input)
    check_answer(part_1(), answers[day][0])
    check_answer(part_2(), answers[day][1])
    fclose_text(@input)

    return 0
}

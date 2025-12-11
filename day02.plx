import `libutil`
use `ctype`
use `stdio`
use `string`

pub fn part_1(none) i64 {
    sum: i64 = 0
    str: string = input.text[0]
    loop {
        str2: string = str
        len1: i32 = 0
        loop while isdigit(str2[]) {
            str2++
            len1++
        }
        str2++
        len2: i32 = 0
        loop while isdigit(str2[]) {
            str2++
            len2++
        }
        n1: i64 = parse_number(@str)
        str++
        n2: i64 = parse_number(@str)
        if len1 % 2 == 0 or len2 % 2 == 0 {
            len: i32 = ? len1 % 2 == 0 then len1 else len2
            factor: i64 = ? (len == 2
                ) then 10 else ? (len == 4
                ) then 100 else ? (len == 6
                ) then 1000 else ? (len == 8
                ) then 10000 else ? (len == 10
                ) then 100000 else 0
            if len == 0 {
                return 0
            }
            h1: i64 = n1 / factor
            h2: i64 = n2 / factor
            loop h: i64 = h1 while h <= h2 .. h++ {
                if h * 10 >= factor and h < factor {
                    i: i64 = factor * h + h
                    if n1 <= i and i <= n2 {
                        sum += i
                    }
                }
            }
        }
        if str[] ~= ',' {
            break
        }
        str++
    }
    return sum
}

pub fn part_2(none) i64 {
    sum: i64 = 0
    str: string = input.text[0]
    loop {
        str2: string = str
        len1: i32 = 0
        loop while isdigit(str2[]) {
            str2++
            len1++
        }
        str2++
        len2: i32 = 0
        loop while isdigit(str2[]) {
            str2++
            len2++
        }
        n1: i64 = parse_number(@str)
        str++
        n2: i64 = parse_number(@str)
        loop n: i64 = n1 while n <= n2 .. ++n {
            buf: [32]char = $(nil)
            ltostr(buf, n)
            len: i32 = strlen(buf)
            is_match: bool = false
            loop m: i32 = 2 while m <= len .. ++m {
                if len % m == 0 {
                    is_match = true
                    w: i32 = len / m
                    loop i: i32 = 1 while i < m .. ++i {
                        loop j: i32 = 0 while j < w .. ++j {
                            if buf[j] ~= buf[j + i * w] {
                                is_match = false
                            }
                        }
                    }
                }
                if is_match {
                    break
                }
            }
            if is_match {
                sum += n
            }
        }
        if str[] ~= ',' {
            break
        }
        str++
    }
    return sum
}

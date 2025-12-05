import `libfile`

# TODO use libc bindings

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

# stdlib.h
extrn fn exit(status: i32) none;

#####

pub fn ftext_close(filetext: *struc FileText) none {
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

pub fn ftext_read(filename: string, filetext: *struc FileText) none {
    ftext_close(filetext)
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

pub fn ftext_dd(i: i32, j: i32, filetext: *struc FileText) char {
    return ? (
        i >= 0 and i < filetext[].lines and j >= 0 and j < filetext[].width
    ) then filetext[].text[i][j] else ' '
}

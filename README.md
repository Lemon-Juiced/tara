# Tara
Tara is a collection of bash scripts that serve as convenient aliases for common tar commands, making archive management easier.

## Installation
Copy `tara.sh` to a directory in your `$PATH` (e.g., `/usr/local/bin`), and make it executable:

```bash
cp tara.sh /usr/local/bin/tara
chmod +x /usr/local/bin/tara
```

You can now run `tara` from anywhere in your terminal.

### Man Page
To install the man page, copy `tara.1` to your system's man directory (e.g., `/usr/local/share/man/man1`):

```bash
cp tara.1 /usr/local/share/man/man1/
mandb  # Update the man page index (May require sudo)
```

You can then view the manual with:

```bash
man tara
```

## Usage
```bash
tara [option] [compression] [name] [files]
```

### Options
- `-b`, `-ball`       Create a tarball
- `-c`, `-compress`   Compress files
- `-d`, `-decompress` Decompress files
- `-h`, `-help`       Show help

### Compression Method Support in tar
| Compression | Flags           | File Extension   | Support Status         | Notes                                 |
|-------------|-----------------|------------------|------------------------|---------------------------------------|
| gzip        | --gz, --gzip    | .tar.gz,         | ✅ Supported           | Very common and fast                  |
| bzip2       | --bz, --bzip2   | .tar.bz2         | ✅ Supported           | Better compression than gzip          |
| xz          | --xz, --xzip    | .tar.xz          | ✅ Supported           | Excellent compression, slower         |
| zstd        | --zs, --zstd    | .tar.zst         | ✅ Supported (Newer)   | Fast & modern, needs recent tar       |
| lzma        | --lzma          | .tar.lzma        | ⚠️ Deprecated          | Older format, mostly replaced by xz   |
| lzip        | --lzip          | .tar.lz          | ⚠️ Optional Support    | Less common, may need external tool   |
| lzop        | --lzop          | .tar.lzo         | ⚠️ Optional Support    | Fast, but rarely used                 |
| compress    | --Z             | .tar.Z           | ⚠️ Legacy/Deprecated   | Very old Unix compression             |

### Warning
Ensure that your tar installation supports the chosen compression algorithm. If your version of tar does not recognize a specific algorithm, the command will fail.

## License
Licensed under GNU GPL v3.

## History
Tara is inspired by an older project called `DTar`, originally written in the D programming language. DTar aimed to be system-agnostic and supported multiple platforms, including Windows, by compiling to native binaries and invoking system commands directly. However, DTar became overly complex for its intended purpose of simplifying tar operations.

Tara takes a different approach by focusing on simplicity, but it intentionally breaks with the traditional Unix philosophy. While the Unix philosophy encourages programs to do one thing well, Tara combines several related tasks—creating, compressing, and decompressing archives—into a single, lightweight bash script. Unlike DTar, which was a suite of separate programs, Tara is easier to maintain and use, but does not strictly adhere to the "do one thing well" principle. Instead, it aims to provide essential archive management features in one convenient tool for Unix-like systems (or any environment that supports bash).

Note: Tara does not support Windows natively. While DTar could run on Windows due to its compiled nature, Tara relies on bash and standard Unix utilities, making it best suited for Linux, macOS, and similar platforms. If your platform supports bash scripting and tar, this program should theoretically work for you as well.

## To Do
1. Fix oversight where file extensions aren't applied to tar file.
2. Add flag like `-nx` to not add an extension.
3. Add option to view, `-v`, inside a tarball.
4. Add option to add, `-a`, to a tarball.
5. Add option to remove, `-r`, from a tarball.

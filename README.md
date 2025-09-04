# Tara
Tara is a collection of bash scripts that serve as convenient aliases for common tar commands, making archive management easier.

## Features
- Simple command-line interface for tar operations
- Automatic file extension handling
- Supports multiple compression formats
- View, add, and remove files from tarballs

## Installation
1. **Copy the script to your PATH and make it executable:**
    ```bash
    cp tara.sh /usr/local/bin/tara
    chmod +x /usr/local/bin/tara
    ```
2. **Add `/usr/local/bin` to your PATH if it's not already there:**
    Add the following line to your `~/.bashrc` (or `~/.zshrc` for Zsh):
    ```bash
    export PATH="$PATH:/usr/local/bin"
    ```
    Then reload your shell:
    ```bash
    source ~/.bashrc
    ```
3. **Install the man page:**
    Create the man1 directory if it doesn't exist:
    ```bash
    sudo mkdir -p /usr/local/share/man/man1
    ```
    Then copy the man page to the directory:
    ```bash
    sudo cp tara.1 /usr/local/share/man/man1/
    sudo mandb  # Update the man page index
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
- `-a`, `-add`           Add files to a tarball
- `-b`, `-ball`          Create a tarball
- `-c`, `-compress`      Compress files
- `-d`, `-decompress`    Decompress files
- `-h`, `-help`          Show help
- `-nx`                  Do not auto-append file extension
- `-r`, `-remove`        Remove files from a tarball
- `-v`, `-view`          View contents of a tarball

### Examples
- Create a gzip-compressed tarball (auto-extension):
    ```bash
    tara -b --gz myarchive file1 file2
    # Creates myarchive.tar.gz
    ```
- Create a tarball without auto-extension:
    ```bash
    tara -b -nx myarchive file1 file2
    # Creates myarchive
    ```
- View contents of a tarball:
    ```bash
    tara -v myarchive.tar.gz
    ```
- Add files to an existing tarball:
    ```bash
    tara -a myarchive.tar.gz newfile1 newfile2
    ```
- Remove files from a tarball:
    ```bash
    tara -r myarchive.tar.gz oldfile.txt
    ```

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

### ⚠️ Warning
Ensure that your tar installation supports the chosen compression algorithm. If your version of tar does not recognize a specific algorithm, the command will fail.

## License
Licensed under GNU GPL v3.

## History
***Tara*** was inspired by a previous project called ***DTar***, which was written in the D programming language. ***DTar*** was designed to be system-agnostic and could run on multiple platforms, including Windows, by compiling to native binaries and directly invoking system commands. However, ***DTar*** ultimately became more complex than necessary for its goal of simplifying tar operations and supported less compression algorithms.

In contrast, ***Tara*** prioritizes simplicity and practicality. It intentionally breaks with the traditional Unix philosophy, which advocates for programs that "do one thing well." Instead, ***Tara*** combines several related tasks such as creating, compressing, decompressing, viewing, adding, and removing files from archives into a single, lightweight `bash` script. While ***DTar*** was a suite of separate programs, ***Tara*** is a unified tool that is easier to maintain and use, providing essential archive management features in one place for Unix-like systems (or any environment that supports `bash`).

> **Note:** ***Tara*** does not support Windows natively. While ***DTar*** could run on Windows due to its compiled nature, ***Tara*** relies on `bash` and standard Unix utilities, making it best suited for Linux, macOS, and similar platforms. If your platform supports `bash` scripting and tar, ***Tara*** should work for you as well.
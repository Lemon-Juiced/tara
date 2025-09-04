#!/bin/bash

show_help() {
        cat << EOF
Tara - Easy tar command aliases

Usage:
    tara [option] [compression] [name] [files]

Options:
    -b, -ball         Create a tarball
    -c, -compress     Compress files
    -d, -decompress   Decompress files
    -v, -view         View contents of a tarball
    -a, -add          Add files to a tarball
    -r, -remove       Remove files from a tarball
    -nx               Do not auto-append file extension
    -h, -help         Show help

Compression Methods:
    --bz, --bzip2
    --gz, --gzip
    --lzip
    --lzma
    --lzop
    --xz, --xzip
    --zs, --zstd
    --Z

Examples:
    # Create a gzip-compressed tarball (auto-extension)
    tara -b --gz myarchive file1 file2
    # Creates myarchive.tar.gz

    # Create a tarball without auto-extension
    tara -b -nx myarchive file1 file2
    # Creates myarchive

    # View contents of a tarball
    tara -v myarchive.tar.gz

    # Add files to an existing tarball
    tara -a myarchive.tar.gz newfile1 newfile2

    # Remove files from a tarball
    tara -r myarchive.tar.gz oldfile.txt
EOF
}

# Parse arguments

option=""
comp=""
no_ext="false"
for arg in "$@"; do
    case "$arg" in
        -b|-ball) option="ball" ;;
        -c|-compress) option="compress" ;;
        -d|-decompress) option="decompress" ;;
        -v|-view) option="view" ;;
        -a|-add) option="add" ;;
        -r|-remove) option="remove" ;;
        -nx) no_ext="true" ;;
        -h|-help) show_help; exit 0 ;;
        --bz|--bzip2) comp="bz2" ;;
        --gz|--gzip) comp="gz" ;;
        --lzip) comp="lz" ;;
        --lzma) comp="lzma" ;;
        --lzop) comp="lzo" ;;
        --xz|--xzip) comp="xz" ;;
        --zs|--zstd) comp="zst" ;;
        --Z) comp="Z" ;;
        *) break ;;
    esac
    shift
done

# Parse [name] and [files]
name=""
if [ $# -ge 1 ]; then
    name="$1"
    shift
fi
files=("$@")

# Auto-append extension unless -nx is set or name already has it
if [ "$no_ext" != "true" ] && [ -n "$name" ]; then
    case "$comp" in
        gz)
            [[ "$name" != *.tar.gz && "$name" != *.tgz ]] && name="$name.tar.gz" ;;
        bz2)
            [[ "$name" != *.tar.bz2 ]] && name="$name.tar.bz2" ;;
        xz)
            [[ "$name" != *.tar.xz ]] && name="$name.tar.xz" ;;
        zst)
            [[ "$name" != *.tar.zst ]] && name="$name.tar.zst" ;;
        lzma)
            [[ "$name" != *.tar.lzma ]] && name="$name.tar.lzma" ;;
        lz)
            [[ "$name" != *.tar.lz ]] && name="$name.tar.lz" ;;
        lzo)
            [[ "$name" != *.tar.lzo ]] && name="$name.tar.lzo" ;;
        Z)
            [[ "$name" != *.tar.Z ]] && name="$name.tar.Z" ;;
    esac
    # If no compression, default to .tar
    if [ -z "$comp" ] && [[ "$name" != *.tar ]]; then
        name="$name.tar"
    fi
fi

# Main logic

case "$option" in
    ball|compress)
        if [ -z "$name" ]; then
            name="archive.tar"
        fi
        tar -cvf "$name" "${files[@]}"
        ;;
    decompress)
        if [ -z "$name" ]; then
            show_help
            exit 1
        fi
        tar -xvf "$name" "${files[@]}"
        ;;
    view)
        if [ -z "$name" ]; then
            show_help
            exit 1
        fi
        tar -tvf "$name"
        ;;
    add)
        if [ -z "$name" ] || [ ${#files[@]} -eq 0 ]; then
            show_help
            exit 1
        fi
        tar --append -vf "$name" "${files[@]}"
        ;;
    remove)
        if [ -z "$name" ] || [ ${#files[@]} -eq 0 ]; then
            show_help
            exit 1
        fi
        tar --delete -vf "$name" "${files[@]}"
        ;;
    *)
        show_help
        ;;
esac

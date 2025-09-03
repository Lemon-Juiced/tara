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
EOF
}

# Parse arguments
option=""
comp=""
shift_args=0
for arg in "$@"; do
    case "$arg" in
        -b|-ball) option="ball" ; shift_args=$((shift_args+1)) ;;
        -c|-compress) option="compress" ; shift_args=$((shift_args+1)) ;;
        -d|-decompress) option="decompress" ; shift_args=$((shift_args+1)) ;;
        -h|-help) show_help; exit 0 ;;
        --bz|--bzip2) comp="j" ; shift_args=$((shift_args+1)) ;;
        --gz|--gzip) comp="z" ; shift_args=$((shift_args+1)) ;;
        --lzip) comp="--lzip" ; shift_args=$((shift_args+1)) ;;
        --lzma) comp="--lzma" ; shift_args=$((shift_args+1)) ;;
        --lzop) comp="--lzop" ; shift_args=$((shift_args+1)) ;;
        --xz|--xzip) comp="J" ; shift_args=$((shift_args+1)) ;;
        --zs|--zstd) comp="--zstd" ; shift_args=$((shift_args+1)) ;;
        --Z) comp="Z" ; shift_args=$((shift_args+1)) ;;
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

# Main logic
case "$option" in
    ball|compress)
        if [ -z "$name" ]; then
            name="archive.tar"
        fi
        if [ -z "$comp" ]; then
            tar -cvf "$name" "${files[@]}"
        else
            tar -cv${comp}f "$name" "${files[@]}"
        fi
        ;;
    decompress)
        if [ -z "$name" ]; then
            show_help
            exit 1
        fi
        if [ -z "$comp" ]; then
            tar -xvf "$name" "${files[@]}"
        else
            tar -xv${comp}f "$name" "${files[@]}"
        fi
        ;;
    *)
        show_help
        ;;
esac

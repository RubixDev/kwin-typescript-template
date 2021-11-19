#!/bin/bash
id="$(grep -oP '(?<=X-KDE-PluginInfo-Name=).*' metadata.desktop)"
GLOBIGNORE=".:..:.pkgignore"

add_file_entries () {
    while read -r pattern; do
        [ -n "$pattern" ] || continue
        [ "${pattern: -1}" != "/" ] || pattern="${pattern:0:-1}"
        GLOBIGNORE+=":$pattern"
    done < "$1"
}

add_file_entries .gitignore
add_file_entries .pkgignore

[[ ! -f "$id.kwinscript" ]] || rm "$id.kwinscript"
exec zip -r9 "$id.kwinscript" -- *

#!/bin/bash
command -v jq > /dev/null || {
    echo "'jq' is not installed on this system. Please install to allow json parsing"
    exit 1
}

get_prop () {
    jq -r ".$1" package.json
}
write_prop () {
    sed -i "s\\^$1=.*$\\$1=$2\\" metadata.desktop
}

displayName="$(get_prop displayName)"
write_prop "Name" "$displayName"

description="$(get_prop description)"
write_prop "Comment" "$description"

main="$(get_prop main)"
write_prop "X-Plasma-MainScript" "${main//contents\//}"

author="$(get_prop author)"
write_prop "X-KDE-PluginInfo-Author" "$author"

name="$(get_prop name)"
write_prop "X-KDE-PluginInfo-Name" "$name"
write_prop "X-KDE-PluginKeyword" "$name"

version="$(get_prop version)"
write_prop "X-KDE-PluginInfo-Version" "$version"

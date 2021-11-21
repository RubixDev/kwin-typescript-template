#!/bin/bash

id="$(grep -oP '(?<=X-KDE-PluginInfo-Name=).*' metadata.desktop)"
if kpackagetool5 --type=KWin/Script --list | grep "^$id$" > /dev/null; then
    kpackagetool5 --type=KWin/Script -r "$id"
fi

kwriteconfig5 --file kwinrc --group Plugins --key "${id}Enabled" --delete

is_loaded="$(qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.isScriptLoaded "$id")"
if [[ "$is_loaded" == "true" ]]; then
    qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript "$id" > /dev/null
fi

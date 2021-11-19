#!/bin/bash

id="$(grep -oP '(?<=X-KDE-PluginInfo-Name=).*' metadata.desktop)"

is_enabled="$(kreadconfig5 --file kwinrc --group Plugins --key "${id}Enabled")"
if [[ "$is_enabled" != "true" ]]; then
    kwriteconfig5 --file kwinrc --group Plugins --key "${id}Enabled" true
fi

is_loaded="$(qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.isScriptLoaded "$id")"
if [[ "$is_loaded" == "true" ]]; then
    qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript "$id" > /dev/null
fi
qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.start

#!/bin/sh
osascript << 'END'
tell application "Google Chrome"
    activate
    open location "chrome://inspect"
    delay 1
    execute front window's active tab javascript "document.getElementById('node-frontend').click()"
end tell
END

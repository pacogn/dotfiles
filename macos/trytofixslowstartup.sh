#!/bin/sh
osascript << 'END'
    property systemList : {¬
        "com.apple.ATS.System.fcache", ¬
        "com.apple.ATSServer.FODB_System", ¬
        "fontTablesAnnex"}
    property localList : {¬
        "501:Classic.fcache", ¬
        "501:Local.fcache", ¬
        "User.fcache", ¬
        "Classic.fodb", ¬
        "Local.fodb", ¬
        "User.fodb", ¬
        "FondResourceCache"}
    tell application "Finder"
        set versionFinder to version as text
    end tell
    if versionFinder starts with "10.3" then
        set localCaches to ((path to "cusr") as text) & "Library:Caches:com.apple.ATS:"
        set systemCaches to ((path to "boot") as text) & "System:Library:Caches:"
        tell application "Finder"
            repeat with name in localList
                try
                    delete file (localCaches & name)
                end try
            end repeat
            repeat with name in systemList
                try
                    delete file (systemCaches & name)
                end try
            end repeat
        end tell
    end if
END

#!/bin/sh
#
# Bash/AppleScript to automagically setup Rails development environment.
# This script opens a terminal windows, maximizes it and opens 4 tabs with:
#   - autospec
#   - tail -f development.log
#   - script/console
#   - mvim in the project folder
#
# Run this script with the project path as argument, ea:
# rails_dev.sh ~/Work/project

# check args
case "$#" in
        1)
                if [ ! -d $1 ]
                then
                        echo "ERROR: $1 is not a valid directory"
                        exit 0
                fi

                if [ ! -f "$1/config/boot.rb" ]
                then
                        echo "ERROR: $1 is not a valid Rails directory (config/boot.rb missing)"
                        exit 0
                fi

                arg="$(cd $1; pwd -P)";export arg
                ;;
        *)
                echo "Usage: $0 <rails project dir>" >&2
                exit 2
                ;;
esac

# redirect stdin
exec <"$0" || exit

# find the start of the AppleScript
found=0
while read v; do
        case "$v" in --*)
                # file offset at start of AppleScript
                found=1; break
                ;;
        esac
done

case "$found" in
    0)
        echo 'shebang: AppleScript not found' >&2
        exit 128
        ;;
esac


# Terminal.app version:
# run the AppleScript
exec arch -i386 /usr/bin/osascript -; exit

-- AppleScript starts here
set projectPath to system attribute "arg"

set Dimensions to (do shell script "system_profiler SPDisplaysDataType | grep Resolution | awk '{print $2, $4}'")
set displayWidth to word 1 of Dimensions
set displayHeight to word 2 of Dimensions

tell application "Terminal"
        activate

        -- Open new terminal window
        -- tell application "System Events" to tell process "Terminal" to keystroke "n" using command down

        -- Maximize
        -- set bounds of the front window to {0, 0, displayWidth, displayHeight}

        -- autospec
        do script with command "cd " & projectPath & " && autospec" in selected tab of the front window

        -- development log
        tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
        delay 0.3
        do script with command "cd " & projectPath & " && tail -f log/development.log" in selected tab of the front window

        -- script/console
        tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
        delay 0.3
        do script with command "cd " & projectPath & " && script/console" in selected tab of the front window

        -- MacVim
        tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
        delay 0.3
        do script with command "cd " & projectPath & " && rake log:clear && mvim" in selected tab of the front window
end tell

## iTerm version:
## run the AppleScript
#exec arch -i386 /usr/bin/osascript -; exit
#
#-- AppleScript starts here
#set projectPath to system attribute "arg"
#
#set Dimensions to (do shell script "system_profiler SPDisplaysDataType | grep Resolution | awk '{print $2, $4}'")
#set displayWidth to word 1 of Dimensions
#set displayHeight to word 2 of Dimensions
#
#tell application "iTerm"
#  -- Maximize
#  set bounds of the front window to {0, 0, displayWidth, displayHeight}
#
#  tell the last terminal
#
#    -- development log
#    activate current session
#    tell the last session
#      set name to "dev log"
#      write text "cd " & projectPath
#      write text "tail -f log/development.log"
#    end tell
#
#    -- autospec
#    launch session "Default Session"
#    tell the last session
#      set name to "rspec"
#      write text "cd " & projectPath
#      write text "autospec"
#    end tell
#
#    -- script/console
#    launch session "Default Session"
#    tell the last session
#      set name to "console"
#      write text "cd " & projectPath
#      write text "script/console"
#    end tell
#
#    -- MacVim
#    launch session "Default Session"
#    tell the last session
#      write text "cd " & projectPath
#      write text "mvim"
#    end tell
#  end tell
#end tell

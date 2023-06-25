###### ThatStella7922's trash bullshit zshrc ######
# 2023.0625.0

myname=$(id -F)

# Homebrew and GPTK stuff
if [ "$(arch)" = "arm64" ]; then
    # Pull arm64 brew's shellenv
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # this is a nice shitting of the prompt
    export PS1="[%B%F{207}%n%b%f%F{9}@%f%F{34}%m%f] %F{39}%1~%f > "
    # the %B adds bold, the %F{207} makes it magenta
    # the %n prints the username, the %b ends the bold and %f ends the color
    # then the %F{9} starts red, then we have an @ and we end the color with %f again
    # then we start another color with %F{34} and print the machine name with %m and end color with %f
    # its all enclosed in some brackets [] then we continue to the current directory
    # color it with %F{39}, spit out the directory with %1~ i think then stop color with %f.
    # then end it off with a > just because i like it
    # %# to show a nice percent sign at the end
else
    # Pull x86_64 brew's shellenv
    eval "$(/usr/local/bin/brew shellenv)"
    export PS1="[%B%F{207}%n%b%f%F{9}@%f%F{34}%m%f - x86_64] %F{39}%1~%f > "
    export PATH="$HOME/Applications/GPTK:$PATH"
    echo "\033[1m[*]\033[0m x86_64 shell session detected, will use x86_64 Homebrew!"
    echo "\033[1m[*]\033[0m Apple GPTK available on this x86_64 shell session! (run gptkhelp)"
    export WINE=`brew --prefix game-porting-toolkit`/bin/wine64
fi

# Environment Variables
# yea idk how else to set the java shit
export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"
export GPG_TTY=$(tty)
export EDITOR="nano"
export VISUAL="nano"

# Aliases
alias ls="ls -AG" #use -AGhl for verbose
alias please="sudo"
alias python="python3"
alias pip="pip3"
# these bottom three add confirmation prompts to rm, cp and mv
alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
# timesavers
alias intel="arch -x86_64"
alias killallwine="killall -9 wineserver && killall -9 wine64-preloader"

# Enable Metal performance HUD for all eligible processes
export MTL_HUD_ENABLED=1

# Shell welcome
test="$(id -F | grep "Stella")"
if [[ $? == "0" ]]; then
    echo -e "Shell setup completed - Hello $myname :3"
else
    echo -e "Shell setup completed - Hi $myname!"
fi
echo

# Homebrew Update Module
if [[ ! -e ~/.zshrcbrewupdated ]]; then
    #file doesn't exist
    echo "This zshrc uses a file named .zshrcbrewupdated to determine when to update\nHomebrew packages."
    echo "This file doesn't exist yet so it will be created now, and a complete Homebrew\nupdate + upgrade will be run as well."
    date +%d > .zshrcbrewupdated
    echo
    brew update
    brew upgrade
else
    todaysdate=$(date +%d)
    brewlastupdateday=$(cat ~/.zshrcbrewupdated)
    # is the last update day the same as today
    if [[ $brewlastupdateday = $todaysdate ]]; then
        # if yes then skip
        echo "Already updated Homebrew packages today, skipping."
    else
        # if not then update and update the date
        echo "Running Homebrew update..."
        echo "(You may now open another shell if you want to get to work immediately)"
        date +%d > .zshrcbrewupdated
        brew update
    fi
fi

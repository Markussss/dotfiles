# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags:$HOME/.npm/bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags:$HOME/.local/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags"

# User specific aliases and functions
alias clip="xclip -selection c"
alias refresh="console cache:clear && rm -rf vendor/ && composer install && console doctrine:schema:update --force"
alias killphp="ps aux | grep php | tr -s ' ' | cut -d ' ' -f 2 | xargs kill &> /dev/null"
alias blog="cd ~/Sites/blog"
alias bashrc="$EDITOR ~/.bashrc && source ~/.bashrc"
alias seleniumchrome="java -jar -Dwebdriver.chrome.driver=/Users/markus/bin/chromedriver /Users/markus/bin/selenium-server-standalone-3.141.59.jar"
alias seleniumfirefox="java -jar -Dwebdriver.gecko.driver=/Users/markus/bin/geckodriver /Users/markus/bin/selenium-server-standalone-3.141.59.jar"
alias composer="php -d memory_limit=-1 `which composer`"
alias codecept="php vendor/bin/codecept"
alias governor="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias powersave="echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias performance="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias gbg="git bisect good"
alias gbb="git bisect bad"

alias fixalt="setxkbmap -option \"nbsp:none\" && xmodmap -e \"keycode 64 = Alt_L\""
alias cd..="cd .."
alias cd.="cd .."

alias rg="rg -p"
alias clear="clear && clear"
alias screenrec="ffmpeg -video_size 1920x1080 -framerate 120 -f x11grab -i :0.0 -f pulse -i default -c:v libx264 -crf 0 -preset ultrafast /home/markus/Videos/Recordings/$(date +\"%Y-%m-%d_%H:%M:%S\").mkv"
alias recscreen="screenrec"
alias ripme="java -jar ~/ripme/ripme.jar"
alias checkdrivers="(sudo lspci -vnn | grep VGA -A 12) && (sudo lshw -numeric -C display)"
alias jadd="jotta-cli add"
alias jstat="jotta-cli status"
alias jscan="jotta-cli scan"
alias jtail="jotta-cli tail"
alias micon="sudo su -c \"echo -n -e '\x02\x02' > /dev/hidraw0\""
alias micoff="sudo su -c \"echo -n -e '\x02\x00' > /dev/hidraw0\""

function wt () {
	while inotifywait -e close_write $1; do $2 $3 $4 $5 $6; printf "\n-----------------------\n"; done
}

function instagram-dl () {
  ripme -u https://www.instagram.com/$1
}
alias chattr='chattr -V'
alias chmod='chmod -v'
alias chown='chown -v'
alias cp='cp -iv'
alias dd='dd status=progress'
alias fsck='fsck -v'
alias grub-install='grub-install -v'
alias kpartx='kpartx -v'
alias losetup='losetup -v'
alias mkdir='mkdir -v'
alias mount='mount -v'
alias mv='mv -iv'
alias partprobe='partprobe -s'
alias rm='rm -Iv'
alias rmdir='rmdir -v'
alias rsync='rsync --progress -v'
alias umount='umount -v'
alias clrg='clear && rg -i'

source ~/.secret-alias
#https://superuser.com/a/382601/521689
alias sudo='sudo '

function cacheclear() {
    while true; do
        console cache:clear
        osascript -e 'display notification "cleared cache!"'
        sleep 300
    done
}

function console() {
    test -f app/console && app/console $@ && return 0
    test -f bin/console && bin/console $@ && return 0
    if [ $(pwd) == "/" ]; then
        echo "found no console"
        return 1
    else
        (cd .. && console $@)
        return 0
    fi
}

function fixtures() {
    console doctrine:database:drop --force $1
    console doctrine:database:create $1
    console doctrine:schema:create $1
    yes | console doctrine:fixtures:load $1
}

function new() {
  mkdir -p "$(dirname "$1")"
  touch $1
  $EXTERNAL_EDITOR $1
}

function rgopen () {
  rg --color never "$1" | grep "$2"  | awk 1 ORS=' ' | sed "s/^/$EXTERNAL_EDITOR /g" | bash
}

function fixconflicts () {
  TEMP_EXTERNAL_EDITOR=$EXTERNAL_EDITOR
  EXTERNAL_EDITOR='code'
  rgopen "<<<<" "\."
  EXTERNAL_EDITOR=$TEMP_EXTERNAL_EDITOR
}

eval "$(pipenv --completion)"


# Set default editor to vim
export EDITOR="vim"
export EXTERNAL_EDITOR="storm"

# eval "$(symfony-autocomplete)"

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
#export BASH_IT_THEME='bobby'
export BASH_IT_THEME='zork'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh

# disable Ctrl+S freezes
stty -ixon
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

if test -f .bashrc_extra; then
  source .bashrc_extra
fi


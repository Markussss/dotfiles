# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags"

# User specific aliases and functions

alias cacheclear="while true; do bin/console cache:clear; osascript -e 'display notification \"cleared cache!\"' && sleep 300; done"
alias blog="cd ~/Sites/blog"
alias bashrc="$EDITOR ~/.bashrc && source ~/.bashrc"
alias seleniumchrome="java -jar -Dwebdriver.chrome.driver=/Users/markus/bin/chromedriver /Users/markus/bin/selenium-server-standalone-3.141.59.jar"
alias seleniumfirefox="java -jar -Dwebdriver.gecko.driver=/Users/markus/bin/geckodriver /Users/markus/bin/selenium-server-standalone-3.141.59.jar"
alias composer="php -d memory_limit=-1 `which composer`"
alias codecept="php vendor/bin/codecept"
alias gbg="git bisect good"
alias gbb="git bisect bad"
alias fixalt="setxkbmap -option \"nbsp:none\" && xmodmap -e \"keycode 64 = Alt_L\""
alias cd..="cd .."
alias cd.="cd .."

alias rg="rg -p"
alias clear="clear && clear"

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

alias aserve="artisan config:clear && artisan cache:clear && artisan route:cache && artisan view:clear && composer dumpautoload && artisan serve"


source ~/.secret-alias
#https://superuser.com/a/382601/521689
alias sudo='sudo '

function console() {
    test -f app/console && app/console $@ && return 0
    test -f bin/console && bin/console $@ && return 0
    if [ $(pwd) == "/" ]; then
        echo "found no console"
        return 1
    else
        (cd .. && console $@)
    fi
}

function fixtures() {
    console doctrine:database:create $1
    console doctrine:schema:create $1
    console doctrine:fixtures:load  $1
}

function new() {
  mkdir -p "$(dirname "$1")"
  touch $1
  $EXTERNAL_EDITOR $1
}

function rgopen () {
  rg --color never "$1" | grep "$2"  | awk 1 ORS=' ' | sed "s/^/code /g" | bash
}

# Set default editor to vim
export EDITOR="vim"
export EXTERNAL_EDITOR="storm"

# eval "$(symfony-autocomplete)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

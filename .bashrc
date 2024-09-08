# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# exit
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags:$HOME/.npm/bin:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags:$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin"
alias killwine="ps aux | grep '\.exe' | tr -s ' ' | cut -d ' ' -f 2 | xargs kill &> /dev/null"
alias minecraft="/home/markus/Minecraft/Minecraft &"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.npm/bin"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export HOMEBREW_NO_ANALYTICS=1
export GJS_PATH=~/.local/share/gnome-shell/extensions/nice-clock@yourusername/

# Set default editor to vim
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

alias gits='git'
alias guit='git'
alias phpstan='docker run -v $PWD:/app --rm ghcr.io/phpstan/phpstan analyse -l 6'
alias psysh='docker run -v $(pwd):/app --rm -it ricc/psysh'
alias gt='git'
alias storm='phpstorm'
alias killwine='ps aux | grep "\.exe" | tr -s " " | cut -d " " -f 2 | xargs kill &> /dev/null'
alias killteams='ps aux | grep "msteams" | tr -s " " | cut -d " " -f 2 | xargs kill &> /dev/null'
alias minecraft='/home/markus/Minecraft/Minecraft &'

# User specific aliases and functions
alias clip="xclip -selection c"
alias killwine="ps aux | grep '\.exe' | tr -s ' ' | cut -d ' ' -f 2 | xargs kill &> /dev/null"
alias minecraft="/home/markus/Minecraft/Minecraft &"
alias refreshdocker="docker-compose up --build db web proxy tools"
alias reloaddb="./tools.sh inv download-db --env=stage && ./tools.sh cp -f /tmp/aunivers-stage\:stage.sql . && mv -f ../aunivers-stage\:stage.sql ../aunivers-stage\:stage.sql.old && mv aunivers-stage\:stage.sql ../"
alias hva="code /Users/markus/notater/hva-jeg-jobber-med.md"
alias redis="docker exec -it aunivers_cache_1 redis-cli -n 1"
alias refresh="console cache:clear && rm -rf vendor/ && composer install && console doctrine:schema:update --force"
alias killphp="ps aux | grep php | tr -s ' ' | cut -d ' ' -f 2 | xargs kill &> /dev/null"
alias blog="cd ~/Sites/blog"
alias bashrc="$EDITOR ~/.bashrc && source ~/.bashrc"
alias seleniumchrome="java -jar -Dwebdriver.chrome.driver=/Users/markus/bin/chromedriver /Users/markus/bin/selenium-server-standalone-3.141.59.jar"
alias seleniumfirefox="java -jar -Dwebdriver.gecko.driver=/Users/markus/bin/geckodriver /Users/markus/bin/selenium-server-standalone-3.141.59.jar"
alias codecept="php vendor/codeception/codeception/codecept"
alias governor="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias powersave="echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias performance="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias gbg="git bisect good"
alias gbb="git bisect bad"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

alias fixalt="setxkbmap -option \"nbsp:none\" && xmodmap -e \"keycode 64 = Alt_L\""

alias brownnoise="play -c 2 --null synth brownnoise reverb bass 6 treble -3"
alias checkdrivers="(sudo lspci -vnn | grep VGA -A 12) && (sudo lshw -numeric -C display)"
alias micon="sudo su -c \"echo -n -e '\x02\x02' > /dev/hidraw0\""
alias micoff="sudo su -c \"echo -n -e '\x02\x00' > /dev/hidraw0\""
alias redshiftgui="(python ~/redshift-gui/redshift-gui.py &)"
# alias fixpermissions="sudo chown markus-in-docker:docker-nginx . -R && sudo chown markus:markus .git .idea node_modules assets -R"

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


# Improve history
# shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=100000

function docker-compose() {
  docker compose $@
}

function fixpermissions() {
  sudo chown markus-in-docker:docker-nginx . -R && \
  sudo chown markus:markus .git/ .idea/ node_modules/ -R && \
  sudo chmod -R 775 . -R
}
function wt () {
	while inotifywait -e close_write $1; do $2 $3 $4 $5 $6; printf "\n-----------------------\n"; done
}

function cacheclear() {
    while true; do
        console cache:clear
        osascript -e 'display notification "cleared cache!"'
        sleep 300
    done
}

function console() {
    web bin/console --no-debug $@
}

function migrate() {
    web bin/console --no-debug ibexa:migrations:migrate
}

function restoresnap() {
    echo "DROP DATABASE ibexa; CREATE DATABASE ibexa;" &&
    docker exec -i ibexa_db mysql -uroot ibexa -e 'DROP DATABASE ibexa; CREATE DATABASE ibexa;' &&
    echo "pv aunivers-test.sql | mysql -uroot ibexa" &&
    pv -petr ../aunivers-test.sql | docker exec -i ibexa_db mysql -uroot ibexa &&
    echo "console cache:clear" &&
    console cache:clear
}

function wt () {
	while inotifywait -e close_write $1; do $2 $3 $4 $5 $6; printf "\n-----------------------\n"; done
}

function rg() {
  /usr/bin/rg -p "$@" | ~/bin/link_to_file.sh
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
  /usr/bin/rg -l --color never "$@" | awk 1 ORS=' ' | sed "s/^/$EXTERNAL_EDITOR /g" | bash
}

function fixconflicts () {
  rgopen "<<<<"
}

### End personal functions -------------------------------------------------------------------------

if [ -f pipenv ]; then
  eval "$(pipenv --completion)"
fi


# Set default editor to vim
export EDITOR="vim"
export EXTERNAL_EDITOR="code"

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
export BASH_IT_THEME='zork'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
unset GIT_HOSTING

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
unset IRC_CLIENT

# Set this to the command you use for todo.txt-cli
unset TODO

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Load Bash It
source "$BASH_IT"/bash_it.sh

# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

if test -f .bashrc_extra; then
  source .bashrc_extra
fi

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags:$HOME/.npm/bin:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags:$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export HOMEBREW_NO_ANALYTICS=1

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

alias composer="php -d memory_limit=-1 /usr/local/bin/composer"
alias governor="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias powersave="echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias performance="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias gbg="git bisect good"
alias gbb="git bisect bad"

alias fixalt="setxkbmap -option \"nbsp:none\" && xmodmap -e \"keycode 64 = Alt_L\""

alias clear="clear && clear"
alias checkdrivers="(sudo lspci -vnn | grep VGA -A 12) && (sudo lshw -numeric -C display)"
alias micon="sudo su -c \"echo -n -e '\x02\x02' > /dev/hidraw0\""
alias micoff="sudo su -c \"echo -n -e '\x02\x00' > /dev/hidraw0\""
alias redshiftgui="(python ~/redshift-gui/redshift-gui.py &)"
alias fixpermissions="sudo chown markus-in-docker:docker-nginx . -R && sudo chown markus:markus .git -R"

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

function api() {
  if [ $1 == "cache:clear" ]; then
    docker exec -it api_web rm -rf var/cache/dev
    docker exec -it api_web ./bin/console --no-debug cache:clear
    docker exec -it api_web ./bin/console --no-debug doctrine:cache:clear-metadata
    docker exec -it api_web ./bin/console --no-debug doctrine:cache:clear-collection-region
    docker exec -it api_web ./bin/console --no-debug doctrine:cache:clear-entity-region
    docker exec -it api_web ./bin/console --no-debug doctrine:cache:clear-metadata
    docker exec -it api_web ./bin/console --no-debug doctrine:cache:clear-query
    docker exec -it api_web ./bin/console --no-debug doctrine:cache:clear-query-region
    docker exec -it api_web ./bin/console --no-debug doctrine:cache:clear-result
  elif [ $1 == "update" ]; then
    docker exec -it api_web ./bin/console --no-debug doctrine:schema:update --force
  elif [ $1 == "migration" ]; then
    docker exec -it api_web ./bin/console --no-debug doctrine:migration:diff
  elif [ $1 == "migrate" ]; then
    docker exec -it api_web ./bin/console --no-debug doctrine:migrations:migrate
  elif [ $1 == "unmigrate" ]; then
    docker exec -it api_web ./bin/console --no-debug doctrine:migrations:migrate prev
  elif [ $1 == "mysql" ]; then
    docker exec -it api_db mysql -uroot -ptest api
  elif [ $1 == "sql" ]; then
    docker exec -it api_web ./bin/console --no-debug doctrine:query:sql "$2"
  elif [ $1 == "empty" ]; then
    api sql "delete from planner_plan_week_resource where 1; \
             delete from planner_yearplan_subject where 1; \
             delete from planner_yearplan_grade where 1; \
             delete from planner_day_resource where 1; \
             delete from planner_plan_subject where 1; \
             delete from planner_plan_grade where 1; \
             delete from planner_resource where 1; \
             delete from planner_member where 1; \
             delete from planner_day where 1; \
             delete from planner_week where 1; \
             delete from planner_plan where 1; \
             delete from planner_yearplan where 1;"
  elif [ $1 == "composer" ]; then
    docker exec -it api_web $@
  elif [ $1 == "reset" ]; then
    docker exec -it api_db mysql -uroot -ptest -e 'drop database api' \
      && docker exec -it api_db mysql -uroot -ptest -e 'create database api' \
      && docker exec -i api_db mysql -uroot -ptest api < ~/api-test.sql \
      && api cache:clear
  else
    docker exec -it api_web ./bin/console --no-debug $@
  fi
}

function assets() {
  if [ $1 == "restart" ]; then
    docker-compose restart assets
  elif [ $1 == "tail" ]; then
    docker logs --follow ibexa_assets
  elif [ $1 == "yarn" ] && [ $2 != "encore" ]; then
    docker exec -it ibexa_assets $@ \
    && sudo /usr/bin/chown markus:markus node_modules/ -R \
    && $@ \
    && sudo /usr/bin/chown 33:docker-nginx node_modules/ -R
  else
    docker exec -it ibexa_assets $@
  fi
}

function cache() {
  if [ $# -eq 0 ]; then
    docker-compose exec cache redis-cli
  elif [ $1 == "restart" ]; then
    docker-compose restart cache
  else
    docker-compose exec cache $@
  fi
}

function web() {
  if [ $1 == "restart" ]; then
    docker-compose restart web
  elif [ $1 == "ssl" ]; then
    docker exec -it ibexa_web sudo rm /usr/share/ca-certificates/mozilla/DST_Root_CA_X3.crt  || true \
    && docker exec -it ibexa_web sudo update-ca-certificates
  else
    docker exec -it ibexa_web $@
  fi
}

function docker-nginx() {
  docker-compose -f docker-compose-nginx.yml -f docker-compose.override.yml $@
}

function wt () {
	while inotifywait -e close_write $1; do $2 $3 $4 $5 $6; printf "\n-----------------------\n"; done
}

function compose-up() {
  yq e -i 'del(.services.web.ports)' docker-compose-nginx.yml \
    && yq e -i 'del(.services.proxy)' docker-compose-nginx.yml \
    && yq e -i 'del(.services.nginx.ports)' docker-compose-nginx.yml \
    && ( sleep 5 && git checkout -- docker-compose-nginx.yml &) \
    && docker-nginx up "$@"
}

function d-c() {
  yq e -i 'del(.services.web.ports)' docker-compose-nginx.yml \
    && yq e -i 'del(.services.nginx.ports)' docker-compose-nginx.yml \
    && yq e -i 'del(.services.proxy.ports)' docker-compose-nginx.yml \
    && docker-compose "$@" \
    && git checkout -- docker-compose.yml docker-compose-nginx.yml
}

function doc-com() {
  yq e -i 'del(.services.web.ports)' docker-compose.yml \
    && docker-compose -f docker-compose.override.yml "$@"
}

doc-com-no-https() {
  yq e -i 'del(.services.web.ports)' docker-compose.yml \
    && yq e -i 'del(.services.nginx.ports)' docker-compose.yml \
    && ( sleep 5 && git checkout -- docker-compose.yml &) \
    && docker-compose \
      -f docker-compose.yml -f \
      ../docker-compose-override-aunivers/docker-compose-no-https.override.yml \
      "$@"
}

function rg() {
  /usr/bin/rg -p "$@" | ~/bin/link_to_file.sh
}

function cacheclear() {
    while true; do
        console cache:clear
        osascript -e 'display notification "cleared cache!"'
        sleep 300
    done
}

function console() {
    test -f docker-compose-nginx.yml && \
        docker-compose -f docker-compose-nginx.yml exec web bin/console $@ && \
        return 0
    test -f console.sh && ./console.sh $@ && return 0
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

function migration() {
    if [ -z "$1" ]; then
        echo "need a content type identifier to match against"
        return 1
    fi
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    BRANCH=${BRANCH#feature/*}
    web bin/console kaliop:migration:generate --type=content_type --mode=update --match-type=identifier --match-value=$1 AppBundle $BRANCH
}

function unmigrate() {
    if [ -z "$1" ]; then
        echo "need a migration to unmigrate"
        return 1
    fi
  web bin/console kaliop:migration:migration $1 --delete
}

function migrate() {
    web bin/console kaliop:migration:migrate
}

function restoresnap() {
    echo "DROP DATABASE aunivers; CREATE DATABASE aunivers;" &&
    docker exec -i aunivers_db_1 mysql -uroot aunivers -e 'DROP DATABASE aunivers; CREATE DATABASE aunivers;' &&
    echo "pv aunivers-test.sql | mysql -uroot aunivers" &&
    pv -petr ../aunivers-test.sql | docker exec -i aunivers_db_1 mysql -uroot aunivers &&
    echo "console cache:clear" &&
    docker exec -it aunivers_web_1 bin/console cache:clear &&
    echo "console cache:pool:clear cache.redis" &&
    docker exec -it aunivers_web_1 bin/console cache:pool:clear cache.redis
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


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

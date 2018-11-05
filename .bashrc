# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PATH="$PATH:$HOME/.config/composer/vendor/bin:$HOME/.phpctags"
# User specific aliases and functions
alias fixalt="setxkbmap -option \"nbsp:none\" && xmodmap -e \"keycode 64 = Alt_L\""
alias cd..="cd .."
alias cd.="cd .."
alias redshiftgui="python /home/markus/redshift-gui/redshift-gui.py"

# Git aliases
alias tinker="php artisan tinker"
alias migrate="composer dumpautoload && php artisan migrate -vvv && php artisan db:seed -vvv"
alias phpspec="php vendor/bin/phpspec"
alias serve="beesu php artisan serve --port=80 &>/dev/null &"
alias serve8000="php artisan serve &>/dev/null &"
alias dropfdv="mysql -uroot -e \"drop database fdvhuset; create database fdvhuset;\""
alias dropfamac="mysql -uroot -e \"drop database famacweb; create database famacweb;\""
alias fixcleaningapp="standard --fix /home/markus/bitbucket/famacweb/famacweb/application/views/cleaning/js/cleaningApp.js"
alias fam="cd /home/markus/bitbucket/famacweb/famacweb && git fetch && git status"
alias fixes="cd /home/markus/bitbucket/fixes/famacweb/famacweb && git fetch && git status"
alias frontend="cd /home/markus/bitbucket/frontend.famacweb && git fetch && git status"
alias backend="cd /home/markus/bitbucket/backend.famacweb && git fetch && git status"
alias initlaravel="cp /home/markus/.env . && composer install && artisan key:generate && migrate"
alias rg="rg -p"
alias less="less -R"
alias gs="git fetch && git status"
alias restartfamac="dropfamac && frontend && migrate"
alias rollback="artisan migrate:rollback && migrate"
alias clear="clear && clear"
# https://theptrk.com/2018/07/11/did-txt-file/
alias did="vim +'normal Go' +'r!date' ~/did.txt"
alias todo="vim +'normal Go -  ' -c 'startinsert' ~/todo.txt"
alias screenrec="ffmpeg -video_size 1920x1080 -framerate 120 -f x11grab -i :0.0 -f pulse -i alsa_output.usb-Creative_Technology_Ltd_Sound_Blaster_E1_0000012297-00.analog-stereo.monitor -c:v libx264 -crf 0 -preset ultrafast /home/markus/Videos/Recordings/$(date +\"%Y-%m-%d_%H:%M:%S\").mkv"
alias recscreen="screenrec"

function gcp () {
  git cherry-pick $1
}

function greset() {
	git checkout -- $1
}

function artisan() {
	php artisan "$@"
}

function createmod() {
	artisan famacweb:createModule $1
}

eval $(thefuck --alias)

# Path to the bash it configuration
export BASH_IT="/home/markus/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
#export BASH_IT_THEME='bobby'
export BASH_IT_THEME='powerline'

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

# Set default editor to vim
export EDITOR="vim"

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

# Load Bash It
source "$BASH_IT"/bash_it.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

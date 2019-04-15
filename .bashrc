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

alias tinker="php artisan tinker"
alias migrate="composer dumpautoload && php artisan migrate -vvv && php artisan db:seed -vvv"
alias phpspec="php vendor/bin/phpspec"
alias serve="beesu php artisan serve --port=80 &>/dev/null &"
alias serve8000="php artisan serve &>/dev/null &"
alias fam="cd /home/markus/bitbucket/famacweb && git fetch && git status"
alias fixes="cd /home/markus/bitbucket/fixes/famacweb && git fetch && git status"
alias frontend="cd /home/markus/bitbucket/frontend.famacweb && git fetch && git status"
alias backend="cd /home/markus/bitbucket/backend.famacweb && git fetch && git status"
alias rg="rg -p"
alias clear="clear && clear"
# https://theptrk.com/2018/07/11/did-txt-file/
alias did="vim +'normal Go' +'r!date' ~/did.txt"
alias todo="vim +'normal Go -  ' -c 'startinsert' ~/todo.txt"
alias screenrec="ffmpeg -video_size 1920x1080 -framerate 120 -f x11grab -i :0.0 -f pulse -i alsa_output.usb-Creative_Technology_Ltd_Sound_Blaster_E1_0000012297-00.analog-stereo.monitor -c:v libx264 -crf 0 -preset ultrafast /home/markus/Videos/Recordings/$(date +\"%Y-%m-%d_%H:%M:%S\").mkv"
alias recscreen="screenrec"

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

alias phinx="vendor/bin/phinx"


source ~/.secret-alias
#https://superuser.com/a/382601/521689
alias sudo='sudo '

function artisan() {
	php artisan "$@"
}

function rgopen () {
  rg --color never "$1" | grep "$2"  | awk 1 ORS=' ' | sed "s/^/code /g" | bash
}

# Set default editor to vim
export EDITOR="vim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="/home/markus/.bash_it"

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

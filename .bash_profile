export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
if [ -f /usr/libexec/java_home ]; then
  export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"
fi
alias ls="ls --color=auto --group-directories"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi

# BEGIN SNIPPET: Platform.sh CLI configuration
HOME=${HOME:-'/Users/markus'}
export PATH="$HOME/"'.platformsh/bin':"$PATH"
if [ -f "$HOME/"'.platformsh/shell-config.rc' ]; then . "$HOME/"'.platformsh/shell-config.rc'; fi # END SNIPPET

### LESS ###
# Enable syntax-highlighting in less.
# brew install source-highlight
# First, add these two lines to ~/.bashrc
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='less -m -N -g -i -J --underline-special --SILENT'

if [ -f /usr/share/locale/no_NO.UTF-8 ]; then
  export LANG=UTF-8
  export LC_ALL=no_NO.UTF-8
  export LC_CTYPE=no_NO.UTF-8
fi

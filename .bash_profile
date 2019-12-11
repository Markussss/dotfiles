export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
alias ls="ls --color=auto --group-directories"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi


if [ $(tty) == "/dev/tty1" ]; then
	exec uwsm start niri
fi

export EDITOR=nvim
export VISUAL=nvim


alias ls="ls --color=auto"
alias bye="exit"
alias nv="nvim"

shopt -s expand_aliases
shopt -s histappend
shopt -s cdspell
shopt -s globstar
shopt -s autocd

HISTFILESIZE=2000

eval "$(thefuck --alias)"
eval "$(direnv hook bash)"

[[ $- != *i* ]] && return

PS1='\u@\h:\w\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# kubectl helper functions
kubexec() {
	podname=$(kubectl get pods | grep "$1" | cut -d ' ' -f 1)

	if [ $podname ]; then
		kubectl exec -it $podname bash
	else
		echo "No pod can be found with the string '$1'"
	fi
}

kubelog() {
	podname=$(kubectl get pods | grep "$1" | cut -d ' ' -f 1)

	if [ $podname ]; then
		kubectl logs $podname
	else
		echo "No pod can be found with the string '$1'"
	fi
}

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
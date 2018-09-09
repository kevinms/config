########################################################################
# Modify .bashrc:
########################################################################

#PS1='┌─[\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]\h\[\e[00m\]:\[\e[1;34m\]\w\[\e[0m\]]\n└─╼ '
PS1='\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ '

########################################################################
# Append to .bashrc:
########################################################################

# Less Colors for Man Pages
#export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
#export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
#export LESS_TERMCAP_me=$'\E[0m'           # end mode
#export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
#export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
#export LESS_TERMCAP_ue=$'\E[0m'           # end underline
#export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# enable completion with commands
complete -cf sudo
complete -cf man

export EDITOR=vim
export CSCOPE_EDITOR=vim

WWW_HOME='~/dev/config/search.html'
export WWW_HOME
alias lynx='lynx -accept_all_cookies -nopause -use_mouse'

alias duck='ssh <user>@<hostname>'
alias debris='ssh <user>@<hostname>'
alias staging='ssh <user>@<hostname>'

if [ $DISPLAY ]; then
	xset r rate 200 25
fi

alias twirl='twirl=(":|" ":/" ":-" ":\\"); echo; while ((1)); do for ((i = 0; i < ${#twirl[@]}; i++)); do echo -ne "\r  ${twirl[$i]}  "; sleep .1; done; done'

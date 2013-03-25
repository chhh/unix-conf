# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
alias ls='ls -h --color=auto'


PSC() { echo -ne "\[\033[${1:-0;38}m\]"; }
[ -n "$CYGWIN" ] && cygpwd="s:^/cygdrive/([a-z])(/|$):\1\:/:;"
function PWD() { echo "$*" |perl -pne \
      's:^'"$HOME"':~:;'"$cygpwd"'s:^(.{10}).{4}.*(.{20})$:$1...$2:;'
}
PR="0;32"       # default color used in prompt is green
if [ "$(id -u)" = 0 ]
  then sudo=41      # root is red background
elif [ "$(id -un)" != "$(basename $HOME)" ]
  then sudo=31  # not root, not self: red text
else sudo="$PR" # standard user color
fi
alias PS1='export PS1="\u@\h \w\$ "'    # if in trouble, run the command 'PS1'
PROMPT_COMMAND='[ $? = 0 ] && PS1=${PS1[1]} || PS1=${PS1[2]}'
PSbase="$(PSC $sudo)\u$(PSC $PR)@\h $(PSC 33)\$(PWD \w)"
PS1[1]="$PSbase$(PSC $PR)\$ $(PSC)"
PS1[2]="$PSbase$(PSC  31)\$ $(PSC)"
PS1="${PS1[1]}"
unset sudo PR PSbase
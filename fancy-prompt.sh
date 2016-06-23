function virtualenv_info(){
    # Get Virtual Env                                                                                                                                                                                                                           
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name                                                                                                                                                                                        
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated                                                                                                                                                                                                  
        venv=''
    fi
    [[ -n "$venv" ]] && echo "($venv)"
}


function _fancy_prompt {
    local RED="\[\033[01;31m\]"
    local GREEN="\[\033[01;32m\]"
    local YELLOW="\[\033[01;33m\]"
    local BLUE="\[\033[01;34m\]"
    local WHITE="\[\033[00m\]"
    local FBLK="\[\033[30m\]" # foreground black
    local FRED="\[\033[31m\]" # foreground red
    local FGRN="\[\033[32m\]" # foreground green
    local FYEL="\[\033[33m\]" # foreground yellow
    local FBLE="\[\033[34m\]" # foreground blue
    local FMAG="\[\033[35m\]" # foreground magenta
    local FCYN="\[\033[36m\]" # foreground cyan
    local FWHT="\[\033[37m\]" # foreground white

    local PROMPT=""
    local VENV="\$(virtualenv_info)";

    local pwd_length=15
    local pwd_symbol="..."
    local newPWD="${PWD/#$HOME/~}"

    if [ $(echo -n $newPWD | wc -c | tr -d " ") -gt $pwd_length ]
    then
        newPWD="...$(echo -n $PWD | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")"
    else
        newPWD="$(echo -n $PWD)"
    fi

  # Working directory                                                                                                                                                                                                                           
    PROMPT=$PROMPT"$VENV$FMAG[\u@\h "
    # PROMPT=$PROMPT"$GREEN[\u@imac "
    PROMPT=$PROMPT$newPWD"]"

  # Git-specific
  local GIT_STATUS=$(git status 2> /dev/null)
  if [ -n "$GIT_STATUS" ] # Are we in a git directory?
  then
    # Open paren
    PROMPT=$PROMPT" $RED("

    # Branch
    PROMPT=$PROMPT$(git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/")

    # Warnings
    PROMPT=$PROMPT$YELLOW

    # Merging
    echo $GIT_STATUS | grep "Unmerged paths" > /dev/null 2>&1
    if [ "$?" -eq "0" ]
    then
      PROMPT=$PROMPT"|MERGING"
    fi

    # Dirty flag
    echo $GIT_STATUS | grep "nothing to commit" > /dev/null 2>&1
    if [ "$?" -eq 0 ]
    then
      PROMPT=$PROMPT
    else
      PROMPT=$PROMPT"*"
    fi

    # Warning for no email setting
    git config user.email | grep @ > /dev/null 2>&1
    if [ "$?" -ne 0 ]
    then
      PROMPT=$PROMPT" !!! NO EMAIL SET !!!"
    fi

    # Closing paren
    PROMPT=$PROMPT"$RED)"
  fi

  # Final $ symbol
  PROMPT=$PROMPT"$BLUE\$$WHITE "

  export PS1=$PROMPT
}

export PROMPT_COMMAND="_fancy_prompt"

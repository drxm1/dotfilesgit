# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# TEST for git......
#
#
export ZSH="$HOME/.oh-my-zsh"

# NNN Plugins
export NNN_PLUG='i:icons;p:preview-tui'
export NNN_FIFO=/tmp/nnn.fifo
export PAGER="less -R"
export MOZ_ENABLE_WAYLAND=1

# NNN fast explorer
source $HOME/.local/zsh/quitcd.zsh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim
export ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/var/lib/snapd/snap/bin
export PATH=$PATH:~/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Allow vi mode in zsh
bindkey -v

alias l="lsd -l --blocks=permission,name"
alias la="lsd -la --blocks=permission,name"
alias ll="lsd -la"
alias lt="lsd -l --blocks=permission,date,name"
alias lta="lsd -la --blocks=permission,date,name"
alias lw="lsd -l --blocks=permission,size,name"
alias alwa="lsd -la --blocks=permission,size,name"
alias nv="nvim ."

# Personal alias useful for studies
#alias serien="nb eth-s4:todos open --tags \"#Serie\" && ~/.dscripts/show_series_with_due.sh"
serien() {
    nb eth-s4:todos open --tags "#Serie" && zsh ~/.dscripts/show_series_with_due.sh
}
alias serien_all="nb eth-s4:todos --tags \"#Serie\""

# Move with vi keys instead of tab etc
zstyle ':completion:*' menu select
zmodload zsh/complist
# ...
# use the vi navigation keys in menu completion
bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history

# Add fzf autocompletion
export FZF_DEFAULT_COMMAND='fd .'
bindkey -s '^S' ' **^I'
# ^I == TAB

# ripgrep config
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# More fzf utils
function check_req () {
    $(type bat > /dev/null 2>&1) && $(type fd > /dev/null 2>&1) && $(type fzf > /dev/null 2>&1)
}

function fzf-nvim () {
    if $(check_req); then
        
        local selected_file=$( \
            fd --type f \
            --hidden \
            --follow \
            --max-depth 1 \
            --exclude .git | \
            
            fzf \
            --info inline \
            --bind 'ctrl-d:preview-down,ctrl-u:preview-up' \
            --preview "bat --style=numbers --theme=gruvbox-dark --color=always {} | head -500" \
            --color=dark \
            --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f \
            --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 \
            --query "$LBUFFER" --prompt="nvim file > "
        )
        
        if [ -n "$selected_file" ]; then
            BUFFER="nvim $selected_file"
            zle accept-line
        fi
        zle reset-prompt
        
    fi
}

function fzf-cd () {
    if $(check_req); then
        
        local selected_file=$( \
            fd --type d \
            --max-depth 1 \
            --hidden \
            --follow \
            --exclude .git | \
            
            fzf --preview "lsd -l --blocks=permission,name {} | head -50" \
            --bind 'ctrl-d:preview-down,ctrl-u:preview-up' \
            --info inline \
            --color=dark \
            --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f \
            --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 \
            --query "$LBUFFER" --prompt="Change dir to > "
        )
        
        if [ -n "$selected_file" ]; then
            BUFFER="cd $selected_file"
            zle accept-line
        fi
        zle reset-prompt
        
    fi
}

zle -N fzf-cd
zle -N fzf-nvim
bindkey '^F' fzf-cd
bindkey '^K' fzf-nvim

# Enable autocompletation again
source ~/.fzf/shell/completion.zsh

# install the package manager for our zsh
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# init
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# load the zsh completions when zsh starts
autoload -U compinit && compinit
zinit cdreplay -q
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# hotkey for completing zsh-autosuggestions
bindkey '^f' autosuggest-accept

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Init fuzzyfinder support
eval "$(fzf --zsh)"
# Init zoxide
eval "$(zoxide init --cmd cd zsh)"

# Add other plugins
# From oh my zsh repository:
zinit snippet OMZP::git
zinit snippet OMZP::dotenv
zinit snippet OMZP::gpg-agent
zinit snippet OMZP::git-auto-fetch
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
# fails: zinit snippet OMZP::ag
# fails: zinit snippet OMZP::bun
zinit snippet OMZP::cabal
zinit snippet OMZP::direnv
zinit snippet OMZP::gcloud
zinit snippet OMZP::copyfile
zinit snippet OMZP::catimg
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::common-aliases
zinit snippet OMZP::fancy-ctrl-z
zinit snippet OMZP::colorize
export ZSH_COLORIZE_TOOL=chroma
alias cat="ccat"

# aliases
alias ls="ls --color"
alias ll="ls -l --color"
alias grep="grep --color=auto"
alias ..="cd .."
alias dotfilesgit="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias dit="dotfilesgit"

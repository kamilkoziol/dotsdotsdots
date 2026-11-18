#BASE CONFIG START 
HISTFILE="$XDG_STATE_HOME"/zsh/history 
mkdir -p "${HISTFILE:h}"
HISTSIZE=10000 
SAVEHIST=10000 
HISTDUP=erase
#BASE CONFIG STOP

#OPTIONS START
setopt autocd extendedglob notify
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
#OPTIONS STOP

#KEYBINDS START
bindkey -e
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
#KEYBINDS STOP

#ZINIT SETUP START
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
#ZINIT STEUP STOP

#PLUGINS START
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
#PLUGISN STOP

#COMPLETION SETUP START
zstyle :compinstall filename '/home/kamil/.config/zsh/.zshrc'
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME"/zsh
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' menu select

eval "$(dircolors -b)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#COMPLETION SETUP STOP

# Starship config
eval "$(starship init zsh)"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"

# NVM config
export NVM_DIR="$XDG_DATA_HOME/nvm"
mkdir -p "$NVM_DIR"
[ -s /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# Aliases
alias ls='ls --color'

#Shell integrations
eval "$(fzf --zsh)"

# Claude
export PATH="$HOME/.local/bin:$PATH"

# Misc
export EDITOR=nvim
export VISUAL=nvim
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export npm_config_cache="${XDG_CACHE_HOME}/npm"
export CLAUDE_CONFIG_DIR="${XDG_CONFIG_HOME}/claude"
export BITWARDEN_SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}"

# pyenv
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
if (( $+commands[pyenv] )); then
  eval "$(pyenv init - zsh)"
  (( $+commands[pyenv-virtualenv-init] )) && eval "$(pyenv virtualenv-init -)"
fi

#UV
eval "$(uv generate-shell-completion zsh)"

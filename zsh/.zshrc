#BASE CONFIG START 
HISTFILE="$XDG_STATE_HOME"/zsh/history 
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
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# Aliases
alias ls='ls --color'

#Shell integrations
eval "$(fzf --zsh)"

# bun
export BUN_INSTALL="$HOME/opt/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun" 

# copilot
export PATH="$PATH:/home/kamil/opt/copilot/bin"

# Claude
export PATH="$HOME/.local/bin:$PATH"

# Misc
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export BITWARDEN_SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}"

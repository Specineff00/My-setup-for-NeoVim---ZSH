# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="mocha" # Required! Options: mocha, flappe, macchiato, latte
CATPPUCCIN_SHOW_TIME=true  # Optional! If set to true, this will add the current time to the prompt.
CATPPUCCIN_SHOW_HOSTNAME="never"  # Optional! Options: never, always, ssh

source $ZSH/oh-my-zsh.sh

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="/opt/homebrew/Cellar/postgresql@18/18.1_1/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export GREENLIGHT_DB_DSN='postgres://greenlight:pa55word@localhost/greenlight?sslmode=disable'
export PATH="$PATH:/opt/homebrew/lib/ruby/gems/4.0.0/bin"

alias ls='colorls'
alias vim='nvim'

eval "$(zoxide init zsh)"
source <(fzf --zsh)

fpath=("@completions@" $fpath)
autoload -Uz compinit && compinit

eval "$("@atuin@" init zsh)"
eval "$("@zoxide@" init zsh)"
eval "$("@starship@" init zsh)"

source "@autosuggestions@"
source "@highlighting@"

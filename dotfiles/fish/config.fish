if status is-interactive
    # Config
    set -g fish_greeting ""
    set -g fish_key_bindings fish_vi_key_bindings

    # Alias
    alias gs="git status"

    # Exa integration
    if command -q eza
        alias ls="eza --icons --group-directories-first"
        alias ll="eza -l --icons --group-directories-first"
        alias la="eza -la --icons --group-directories-first"
    end

    # Add zoxide integration
    if command -q zoxide
        alias cd="z"
        zoxide init fish | source
    end

    # Add zellij support
    if command -q zellij
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end

# aliases.zsh

# --- eza (modern ls) ---
alias ls='eza --group-directories-first --icons=auto'
alias l='eza -lah --group-directories-first --icons=auto --git'
alias ll='eza -lh --group-directories-first --icons=auto --git'
alias la='eza -lah --group-directories-first --icons=auto --git'
alias lt='eza --tree --level=2 --group-directories-first --icons=auto'
alias lt3='eza --tree --level=3 --group-directories-first --icons=auto'

# --- bat (modern cat) ---
alias cat='bat --paging=never'
alias catp='bat --paging=never --style=plain'

# --- navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# --- git / tools ---
alias lg='lazygit'
alias gs='git status -sb'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'

# --- safety / misc ---
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h'
alias path='echo $PATH | tr ":" "\n"'
alias reload='exec zsh'

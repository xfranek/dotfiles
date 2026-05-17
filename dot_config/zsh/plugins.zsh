# plugins.zsh — ORDER MATTERS. Do not reshuffle blocks without checking the
# upstream READMEs. Sequence:
#   fzf  ->  fzf-tab  ->  zoxide  ->  starship
#   ->  autosuggestions  ->  syntax-highlighting  ->  history-substring-search

# --- fzf: Ctrl-R history, Ctrl-T files, Alt-C cd ---
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 45% --layout=reverse --border --info=inline --color=fg:-1,bg:-1,hl:6,fg+:15,bg+:0,hl+:6,info:8,prompt:5,pointer:5,marker:2,spinner:6'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range=:300 {} 2>/dev/null || eza --tree --level=2 --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"

# --- fzf-tab: tab-completion through fzf. After compinit, BEFORE the
#     widget-wrapping plugins below (autosuggestions / syntax-highlighting). ---
if [ -f "$HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh" ]; then
  source "$HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh"
fi

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' group-name ''
zstyle ':fzf-tab:*' fzf-flags --height=45% --layout=reverse --border
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'

# --- zoxide: replaces `cd` (jump with `cd foo`, interactive with `cdi`) ---
eval "$(zoxide init zsh --cmd cd)"

# --- starship prompt ---
eval "$(starship init zsh)"

# --- zsh-autosuggestions: gray inline suggestion from history ---
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
# → / End already accept the whole suggestion; add Ctrl-Space too
bindkey '^ ' autosuggest-accept

# --- zsh-syntax-highlighting: must come AFTER autosuggestions and BEFORE
#     history-substring-search ---
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --- zsh-history-substring-search: type a prefix, then ↑/↓ to walk ONLY the
#     history lines that start with what you typed ---
source "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up      # ↑
bindkey '^[[B' history-substring-search-down    # ↓
bindkey '^[OA' history-substring-search-up      # ↑ (application cursor mode)
bindkey '^[OB' history-substring-search-down    # ↓ (application cursor mode)
bindkey '^P'   history-substring-search-up
bindkey '^N'   history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=6,fg=0,bold'

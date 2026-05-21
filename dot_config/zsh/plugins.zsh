# plugins.zsh — ORDER MATTERS. Do not reshuffle blocks without checking the
# upstream READMEs. Sequence:
#   fzf  ->  fzf-tab  ->  zoxide  ->  starship
#   ->  zsh-sage (autosuggestions)  ->  syntax-highlighting

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

# --- zsh-sage: intelligent autosuggestions with multi-signal ranking
#     (frequency / recency / directory / sequence / success). Replaces
#     zsh-autosuggestions and history-substring-search. → accepts, Ctrl+N
#     cycles alternatives. `hm <prompt>` for AI commands (`zsage ai` to setup). ---
source "$HOMEBREW_PREFIX/opt/zsh-sage/zsh-sage.plugin.zsh"

# --- zsh-syntax-highlighting: must come AFTER autosuggestions ---
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

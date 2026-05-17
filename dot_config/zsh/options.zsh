# options.zsh — shell behaviour, history, keybinding base

bindkey -e   # emacs keybindings (Ctrl-A/E/R/etc.)

# --- history (load-bearing for the "type prefix + ↑" feature) ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000

setopt EXTENDED_HISTORY          # timestamp + duration per entry
setopt SHARE_HISTORY             # live history shared across open shells
setopt HIST_IGNORE_DUPS          # don't record an entry equal to the previous
setopt HIST_IGNORE_ALL_DUPS      # delete older duplicate of a re-run command
setopt HIST_IGNORE_SPACE         # leading space => not recorded (secrets etc.)
setopt HIST_FIND_NO_DUPS         # no dupes while searching history
setopt HIST_SAVE_NO_DUPS         # no dupes written to HISTFILE
setopt HIST_REDUCE_BLANKS        # trim superfluous whitespace
setopt HIST_VERIFY               # expand !! etc. into the line, don't run blind

# --- navigation ---
setopt AUTO_CD                   # `foo` == `cd foo` if foo is a dir
setopt AUTO_PUSHD                # cd pushes onto the dir stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# --- completion / misc quality of life ---
setopt COMPLETE_IN_WORD          # complete from cursor, not just end of word
setopt ALWAYS_TO_END             # move cursor to end after completion
setopt INTERACTIVE_COMMENTS      # allow # comments in interactive shell
setopt NUMERIC_GLOB_SORT
unsetopt BEEP
unsetopt FLOW_CONTROL            # free up Ctrl-S / Ctrl-Q

# dotfiles

Pro zsh setup, managed with [chezmoi](https://chezmoi.io). macOS / Apple Silicon.

## What's in here

| Tool | Role |
|------|------|
| **starship** | prompt (Tokyo Night-ish, two-line) |
| **zoxide** | mapped onto `cd` — `cd foo` jumps to frecent dirs, `cdi` interactive |
| **eza** | `ls` / `l` / `ll` / `la` / `lt` with icons + git |
| **bat** | `cat` with syntax highlighting |
| **fzf** | `Ctrl-R` history · `Ctrl-T` files · `Alt-C` cd |
| **fzf-tab** | tab-completion through fzf (fetched via `.chezmoiexternal.toml`) |
| **zsh-autosuggestions** | gray inline suggestion from history (`→` / `Ctrl-Space` accept) |
| **zsh-history-substring-search** | type a prefix, then `↑`/`↓` walks matching history |
| **zsh-syntax-highlighting** | command-line syntax colors |
| **lazygit** | `lg` — git TUI, diffs via delta |
| **yazi** | `y` — file manager, `Q` cd's to the dir you ended in |

Packages are declared in `Brewfile` and installed automatically by the
`run_onchange_before_00-install-packages.sh.tmpl` hook on every `chezmoi apply`
where the Brewfile changed.

## Bootstrap on a fresh machine

```sh
# 1. Homebrew + chezmoi
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi

# 2. Pull + apply (installs Brewfile, fetches fzf-tab, symlinks everything)
chezmoi init --apply xfranek
```

Then set your terminal font to **JetBrainsMono Nerd Font** and restart the shell.

## Daily use

```sh
chezmoi edit ~/.zshrc      # edit a managed file (opens the source copy)
chezmoi apply              # apply pending changes to $HOME
chezmoi cd                 # jump into the source repo (git here)
chezmoi update             # git pull + apply
```

`~/.zshrc.pre-chezmoi.bak` / `~/.zprofile.pre-chezmoi.bak` are the originals
from first install — safe to delete once you're happy.

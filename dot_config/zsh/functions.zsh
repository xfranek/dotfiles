# functions.zsh

# yazi wrapper: quit with `q` stays put, quit with `Q` cd's to last dir.
# `builtin cd` is used because `cd` is the zoxide function.
function y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# make a dir and step into it
function mkcd() {
  mkdir -p -- "$1" && builtin cd -- "$1"
}

# extract almost anything
function extract() {
  local f="$1"
  [ -f "$f" ] || { echo "extract: '$f' is not a file"; return 1; }
  case "$f" in
    *.tar.bz2|*.tbz2) tar xjf "$f" ;;
    *.tar.gz|*.tgz)   tar xzf "$f" ;;
    *.tar.xz)         tar xJf "$f" ;;
    *.tar)            tar xf  "$f" ;;
    *.bz2)            bunzip2 "$f" ;;
    *.gz)             gunzip  "$f" ;;
    *.zip)            unzip   "$f" ;;
    *.7z)             7z x    "$f" ;;
    *.rar)            unrar x "$f" ;;
    *) echo "extract: don't know how to handle '$f'"; return 1 ;;
  esac
}

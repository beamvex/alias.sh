#!/bin/sh

set -eu

REPO_RAW_BASE_DEFAULT="https://raw.githubusercontent.com/beamvex/alias.sh/main"

raw_base="${ALIAS_SH_RAW_BASE:-$REPO_RAW_BASE_DEFAULT}"

if [ -n "${ALIAS_SH_INSTALL_DIR:-}" ]; then
  install_dir="$ALIAS_SH_INSTALL_DIR"
else
  install_dir="$HOME/.config/alias.sh"
fi

alias_file="$install_dir/alias.sh"

ensure_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "error: missing required command: $1" >&2
    exit 1
  fi
}

detect_shell_name() {
  if [ -n "${SHELL:-}" ]; then
    basename "$SHELL"
    return
  fi

  if command -v ps >/dev/null 2>&1; then
    ps -p "$$" -o comm= 2>/dev/null | tr -d ' ' || true
  fi
}

choose_rc_file() {
  shell_name="$(detect_shell_name)"

  case "$shell_name" in
    zsh)
      echo "$HOME/.zshrc"
      ;;
    bash|sh|dash|ksh|busybox)
      echo "$HOME/.bashrc"
      ;;
    *)
      echo "$HOME/.bashrc"
      ;;
  esac
}

download_aliases() {
  ensure_cmd curl

  mkdir -p "$install_dir"

  tmp="$alias_file.tmp.$$"

  curl -fsSL "$raw_base/alias.sh" -o "$tmp"
  chmod 0644 "$tmp"
  mv "$tmp" "$alias_file"
}

ensure_source_line() {
  rc_file="$1"
  source_line="source \"$alias_file\""

  if [ ! -f "$rc_file" ]; then
    : > "$rc_file"
  fi

  if grep -Fq "$alias_file" "$rc_file"; then
    return
  fi

  printf '\n%s\n' "$source_line" >> "$rc_file"
}

main() {
  rc_file="$(choose_rc_file)"

  download_aliases
  ensure_source_line "$rc_file"

  echo "Installed: $alias_file"
  echo "Updated rc: $rc_file"
  echo "Restart your terminal or run: . \"$rc_file\""
}

main "$@"

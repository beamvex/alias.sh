#!/bin/bash

# Author: Robert Forster
# Date: 2026-05-27
# Description: A collection of terminal aliases for everyday development tasks (git, docker, apt, node, python, terraform).

ALIAS_SH_PREFIX="${ALIAS_SH_PREFIX:-@}"
ALIAS_SH_GIT_PREFIX="${ALIAS_SH_GIT_PREFIX:-g}"
ALIAS_SH_DOCKER_PREFIX="${ALIAS_SH_DOCKER_PREFIX:-d}"
ALIAS_SH_PYTHON_PREFIX="${ALIAS_SH_PYTHON_PREFIX:-p}"
ALIAS_SH_NODE_PREFIX="${ALIAS_SH_NODE_PREFIX:-n}"
ALIAS_SH_TERRAFORM_PREFIX="${ALIAS_SH_TERRAFORM_PREFIX:-tf}"
ALIAS_SH_TERRAGRUNT_PREFIX="${ALIAS_SH_TERRAGRUNT_PREFIX:-tg}"
ALIAS_SH_APT_PREFIX="${ALIAS_SH_APT_PREFIX:-apt}"
ALIAS_SH_BASH_PREFIX="${ALIAS_SH_BASH_PREFIX:-}"
ALIAS_SH_VSCODE_PREFIX="${ALIAS_SH_VSCODE_PREFIX:-v}"
ALIAS_SH_WINDSURF_PREFIX="${ALIAS_SH_WINDSURF_PREFIX:-w}"
ALIAS_SH_TAR_PREFIX="${ALIAS_SH_TAR_PREFIX:-t}"
ALIAS_SH_TYPESCRIPT_PREFIX="${ALIAS_SH_TYPESCRIPT_PREFIX:-ts}"
ALIAS_SH_RUST_PREFIX="${ALIAS_SH_RUST_PREFIX:-rs}"
ALIAS_SH_CARGO_PREFIX="${ALIAS_SH_CARGO_PREFIX:-cg}"
ALIAS_SH_AWS_PREFIX="${ALIAS_SH_AWS_PREFIX:-aws}"
ALIAS_SH_GCP_PREFIX="${ALIAS_SH_GCP_PREFIX:-gcp}"

# ─── Alias help storage ───────────────────────────────────────────────────────

declare -A _ALIAS_HELP
declare -a _ALIAS_GROUPS

_alias_help() {
  printf '%s' "${_ALIAS_HELP[$1]}"
}

_alias_help_all() {
  local group first=1
  for group in "${_ALIAS_GROUPS[@]}"; do
    [ "$first" = 1 ] || printf '\n'
    first=0
    printf '%s' "${_ALIAS_HELP[$group]}"
  done
}

# ─── _register_aliases <group> <prefix> <array_name> ─────────────────────────
# Registers all aliases from an associative array and creates a help/passthrough
# function for the bare prefix. Array entries: [suffix]="command|description"
# An empty key "" defines the base command (passed through when called with args).

_register_aliases() {
  local group="$1"
  local prefix="$2"
  local arr_name="$3"
  local -n _arr="$arr_name"

  local suffix entry cmd desc base_cmd="" help_text _line

  printf -v help_text '\033[1m%s\033[0m  (prefix: \033[36m%s\033[0m)\n\n' "$group" "$prefix"

  # Print the _base entry first, then all other suffixes alphabetically
  if [[ -v '_arr[_base]' ]]; then
    entry="${_arr[_base]}"
    base_cmd="${entry%%|*}"
    desc="${entry##*|}"
    printf -v _line '  \033[33m%-16s\033[0m  %-28s  \033[2m%s\033[0m\n' "${prefix}" "$base_cmd" "$desc"
    help_text+="$_line"
  fi

  while IFS= read -r suffix; do
    [ "$suffix" = '_base' ] && continue
    entry="${_arr[$suffix]}"
    cmd="${entry%%|*}"
    desc="${entry##*|}"
    printf -v _line '  \033[33m%-16s\033[0m  %-28s  \033[2m%s\033[0m\n' "${prefix}${suffix}" "$cmd" "$desc"
    help_text+="$_line"
  done < <(printf '%s\n' "${!_arr[@]}" | sort)

  _ALIAS_HELP["$arr_name"]="$help_text"
  _ALIAS_GROUPS+=("$arr_name")

  for suffix in "${!_arr[@]}"; do
    [ "$suffix" = '_base' ] && continue
    cmd="${_arr[$suffix]%%|*}"
    eval "alias ${prefix}${suffix}='${cmd}'"
  done

  if [ -n "$base_cmd" ]; then
    eval "${prefix}() { if [ \"\$#\" -eq 0 ]; then _alias_help '${arr_name}'; else ${base_cmd} \"\$@\"; fi; }"
  else
    alias "${prefix}"="_alias_help '${arr_name}'"
  fi
}

# ─── Alias group definitions ──────────────────────────────────────────────────

# Bash aliases
declare -A _ALIASES_bash=(
  ["ll"]="ls -la|List files in long format"
  ["lhrt"]="ls -lhrta|List files sorted by modification time"
  ["le"]="less|Page through text"
  ["clr"]="clear|Clear the terminal"
  ["up"]="_alias_update|Update alias.sh and reload shell rc"
)

# apt aliases
declare -A _ALIASES_apt=(
  ["u"]="sudo apt update|Update package list"
  ["ug"]="sudo apt upgrade|Upgrade installed packages"
  ["i"]="sudo apt install|Install a package"
  ["r"]="sudo apt remove|Remove a package"
  ["purge"]="sudo apt purge|Purge a package and its config"
  ["arem"]="sudo apt autoremove|Remove unused dependencies"
)

# Git aliases
declare -A _ALIASES_git=(
  ["_base"]="git|Git version control"
  ["i"]="git init -b main|Init a new repo on main"
  ["co"]="git checkout|Checkout a branch or file"
  ["cb"]="git checkout -b|Create and checkout a new branch"
  ["s"]="git status|Show working tree status"
  ["a"]="git add|Stage files"
  ["aa"]="git add --all|Stage all changes"
  ["c"]="git commit|Commit staged changes"
  ["cam"]="git commit -am|Stage all tracked files and commit"
  ["acp"]="_gacp|Add all, commit with message, and push"
  ["ph"]="git push|Push to remote"
  ["pu"]="git push -u origin HEAD|Push and set upstream"
  ["p"]="git pull|Pull from remote"
  ["l"]="git log|Show commit log"
)

# Docker aliases
declare -A _ALIASES_docker=(
  ["_base"]="docker|Docker container runtime"
  ["ps"]="docker ps|List running containers"
  ["pa"]="docker ps -a|List all containers"
  ["stop"]="docker stop|Stop a container"
  ["rm"]="docker rm|Remove a container"
  ["rmi"]="docker rmi|Remove an image"
  ["exec"]="docker exec|Execute a command in a container"
  ["logs"]="docker logs|Show container logs"
  ["build"]="docker build|Build an image"
  ["cp"]="docker-compose|Docker Compose"
)

# Python aliases
declare -A _ALIASES_python=(
  ["_base"]="python|Python interpreter"
  ["i"]="pip3|Python package manager"
)

# Node aliases
declare -A _ALIASES_node=(
  ["_base"]="node|Node.js runtime"
  ["i"]="npm install|Install dependencies"
  ["id"]="npm install --save-dev|Install as dev dependency"
  ["is"]="npm install --save|Install as production dependency"
  ["gi"]="npm install -g|Install package globally"
  ["gid"]="npm install -g --save-dev|Install globally as dev dep"
  ["gis"]="npm install -g --save|Install globally as prod dep"
  ["s"]="npm start|Start the project"
  ["d"]="npm run dev|Run dev script"
  ["r"]="npm run|Run an npm script"
  ["p"]="npm|npm package manager"
  ["in"]="npm init|Initialize a new package"
  ["y"]="yarn|Yarn package manager"
  ["pn"]="pnpm|pnpm package manager"
)

# Terraform/Terragrunt aliases
declare -A _ALIASES_terraform=(
  ["_base"]="terraform|Terraform IaC tool"
  ["i"]="terraform init|Initialize working directory"
  ["p"]="terraform plan|Preview infrastructure changes"
  ["a"]="terraform apply|Apply infrastructure changes"
  ["r"]="terraform refresh|Refresh state against real infrastructure"
  ["o"]="terraform output|Show output values"
  ["s"]="terraform show|Show state or plan file"
  ["st"]="terraform state|Manage state"
  ["t"]="terraform taint|Mark resource for recreation"
  ["u"]="terraform untaint|Remove taint from resource"
  ["v"]="terraform validate|Validate configuration files"
  ["w"]="terraform workspace|Manage workspaces"
  ["d"]="terraform destroy|Destroy managed infrastructure"
  ["g"]="terraform graph|Generate a resource graph"
)

declare -A _ALIASES_terragrunt=(
  ["_base"]="terragrunt|Terragrunt wrapper for Terraform"
)

# VSCode aliases
declare -A _ALIASES_vscode=(
  ["_base"]="code|Visual Studio Code"
)

# Windsurf aliases
declare -A _ALIASES_windsurf=(
  ["_base"]="windsurf|Windsurf IDE"
)

# tar aliases
declare -A _ALIASES_tar=(
  ["_base"]="tar|Archive utility"
)

# TypeScript aliases
declare -A _ALIASES_typescript=(
  ["_base"]="tsc|TypeScript compiler"
)

# Rust aliases
declare -A _ALIASES_rust=(
  ["_base"]="rustc|Rust compiler"
)

# Cargo aliases
declare -A _ALIASES_cargo=(
  ["_base"]="cargo|Rust package manager"
)

# AWS aliases
declare -A _ALIASES_aws=(
  ["_base"]="aws|AWS CLI"
)

# GCP aliases
declare -A _ALIASES_gcp=(
  ["_base"]="gcloud|Google Cloud CLI"
)

# ─── gacp helper ──────────────────────────────────────────────────────────────

_alias_update() {
  curl -fsSL "https://raw.githubusercontent.com/beamvex/alias.sh/main/install.sh" | sh

  if [ -n "${ZSH_VERSION:-}" ]; then
    . "$HOME/.zshrc"
  else
    . "$HOME/.bashrc"
  fi
}

_gacp() {
  if [ "$#" -lt 1 ]; then
    echo "usage: ${ALIAS_SH_PREFIX}${ALIAS_SH_GIT_PREFIX}acp <commit message>" >&2
    return 2
  fi
  git add --all && git commit -am "$*" && git push
}

# ─── Register all groups ──────────────────────────────────────────────────────

_register_aliases "Bash"       "${ALIAS_SH_PREFIX}${ALIAS_SH_BASH_PREFIX}"       _ALIASES_bash
_register_aliases "APT"        "${ALIAS_SH_PREFIX}${ALIAS_SH_APT_PREFIX}"        _ALIASES_apt
_register_aliases "Git"        "${ALIAS_SH_PREFIX}${ALIAS_SH_GIT_PREFIX}"        _ALIASES_git
_register_aliases "Docker"     "${ALIAS_SH_PREFIX}${ALIAS_SH_DOCKER_PREFIX}"     _ALIASES_docker
_register_aliases "Python"     "${ALIAS_SH_PREFIX}${ALIAS_SH_PYTHON_PREFIX}"     _ALIASES_python
_register_aliases "Node"       "${ALIAS_SH_PREFIX}${ALIAS_SH_NODE_PREFIX}"       _ALIASES_node
_register_aliases "Terraform"  "${ALIAS_SH_PREFIX}${ALIAS_SH_TERRAFORM_PREFIX}"  _ALIASES_terraform
_register_aliases "Terragrunt" "${ALIAS_SH_PREFIX}${ALIAS_SH_TERRAGRUNT_PREFIX}" _ALIASES_terragrunt
_register_aliases "VSCode"     "${ALIAS_SH_PREFIX}${ALIAS_SH_VSCODE_PREFIX}"     _ALIASES_vscode
_register_aliases "Windsurf"   "${ALIAS_SH_PREFIX}${ALIAS_SH_WINDSURF_PREFIX}"   _ALIASES_windsurf
_register_aliases "tar"        "${ALIAS_SH_PREFIX}${ALIAS_SH_TAR_PREFIX}"        _ALIASES_tar
_register_aliases "TypeScript" "${ALIAS_SH_PREFIX}${ALIAS_SH_TYPESCRIPT_PREFIX}" _ALIASES_typescript
_register_aliases "Rust"       "${ALIAS_SH_PREFIX}${ALIAS_SH_RUST_PREFIX}"       _ALIASES_rust
_register_aliases "Cargo"      "${ALIAS_SH_PREFIX}${ALIAS_SH_CARGO_PREFIX}"      _ALIASES_cargo
_register_aliases "AWS"        "${ALIAS_SH_PREFIX}${ALIAS_SH_AWS_PREFIX}"        _ALIASES_aws
_register_aliases "GCP"        "${ALIAS_SH_PREFIX}${ALIAS_SH_GCP_PREFIX}"        _ALIASES_gcp

alias "${ALIAS_SH_PREFIX}"='_alias_help_all'

unset ALIAS_SH_PREFIX \
      ALIAS_SH_GIT_PREFIX \
      ALIAS_SH_DOCKER_PREFIX \
      ALIAS_SH_PYTHON_PREFIX \
      ALIAS_SH_NODE_PREFIX \
      ALIAS_SH_TERRAFORM_PREFIX \
      ALIAS_SH_TERRAGRUNT_PREFIX \
      ALIAS_SH_APT_PREFIX \
      ALIAS_SH_BASH_PREFIX \
      ALIAS_SH_VSCODE_PREFIX \
      ALIAS_SH_WINDSURF_PREFIX \
      ALIAS_SH_TAR_PREFIX \
      ALIAS_SH_TYPESCRIPT_PREFIX \
      ALIAS_SH_RUST_PREFIX \
      ALIAS_SH_CARGO_PREFIX \
      ALIAS_SH_AWS_PREFIX \
      ALIAS_SH_GCP_PREFIX





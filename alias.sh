#!/bin/bash

# Author: Robert Forster
# Date: 2026-05-27
# Description: A collection of terminal aliases for everyday development tasks (git, docker, apt, node, python, terraform).

PREFIX="${PREFIX:-@}"
GIT_PREFIX="${GIT_PREFIX:-g}"
DOCKER_PREFIX="${DOCKER_PREFIX:-d}"
PYTHON_PREFIX="${PYTHON_PREFIX:-p}"
NODE_PREFIX="${NODE_PREFIX:-n}"
TERRAFORM_PREFIX="${TERRAFORM_PREFIX:-tf}"
TERRAGRUNT_PREFIX="${TERRAGRUNT_PREFIX:-tg}"
APT_PREFIX="${APT_PREFIX:-apt}"
BASH_PREFIX="${BASH_PREFIX:-}"
VSCODE_PREFIX="${VSCODE_PREFIX:-v}"
WINDSURF_PREFIX="${WINDSURF_PREFIX:-w}"
TAR_PREFIX="${TAR_PREFIX:-t}"
TYPESCRIPT_PREFIX="${TYPESCRIPT_PREFIX:-ts}"
RUST_PREFIX="${RUST_PREFIX:-rs}"
CARGO_PREFIX="${CARGO_PREFIX:-cg}"

# ─── Alias help storage ───────────────────────────────────────────────────────

declare -A _ALIAS_HELP
declare -a _ALIAS_GROUPS

_alias_help() {
  printf '%s\n' "${_ALIAS_HELP[$1]}"
}

_alias_help_all() {
  local group
  for group in "${_ALIAS_GROUPS[@]}"; do
    printf '%s\n' "${_ALIAS_HELP[$group]}"
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

  local suffix entry cmd desc base_cmd="" help_text

  help_text="$(printf '\033[1m%s\033[0m (prefix: \033[36m%s\033[0m)\n' "$group" "$prefix")"

  # Print the _base entry first, then all other suffixes alphabetically
  if [[ -v '_arr[_base]' ]]; then
    entry="${_arr[_base]}"
    base_cmd="${entry%%|*}"
    desc="${entry##*|}"
    help_text+="$(printf '  \033[33m%-16s\033[0m  %-30s  %s\n' "${prefix}" "$base_cmd" "$desc")"
  fi

  while IFS= read -r suffix; do
    [ "$suffix" = '_base' ] && continue
    entry="${_arr[$suffix]}"
    cmd="${entry%%|*}"
    desc="${entry##*|}"
    help_text+="$(printf '  \033[33m%-16s\033[0m  %-30s  %s\n' "${prefix}${suffix}" "$cmd" "$desc")"
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
    eval "${prefix}() { _alias_help '${arr_name}'; }"
  fi
}

# ─── Alias group definitions ──────────────────────────────────────────────────

# Bash aliases
declare -A _ALIASES_bash=(
  ["ll"]="ls -la|List files in long format"
  ["lhrt"]="ls -lhrta|List files sorted by modification time"
  ["le"]="less|Page through text"
  ["clr"]="clear|Clear the terminal"
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

# ─── gacp helper ──────────────────────────────────────────────────────────────

_gacp() {
  if [ "$#" -lt 1 ]; then
    echo "usage: ${PREFIX}${GIT_PREFIX}acp <commit message>" >&2
    return 2
  fi
  git add --all && git commit -am "$*" && git push
}

# ─── Register all groups ──────────────────────────────────────────────────────

_register_aliases "Bash"       "${PREFIX}${BASH_PREFIX}"       _ALIASES_bash
_register_aliases "APT"        "${PREFIX}${APT_PREFIX}"        _ALIASES_apt
_register_aliases "Git"        "${PREFIX}${GIT_PREFIX}"        _ALIASES_git
_register_aliases "Docker"     "${PREFIX}${DOCKER_PREFIX}"     _ALIASES_docker
_register_aliases "Python"     "${PREFIX}${PYTHON_PREFIX}"     _ALIASES_python
_register_aliases "Node"       "${PREFIX}${NODE_PREFIX}"       _ALIASES_node
_register_aliases "Terraform"  "${PREFIX}${TERRAFORM_PREFIX}"  _ALIASES_terraform
_register_aliases "Terragrunt" "${PREFIX}${TERRAGRUNT_PREFIX}" _ALIASES_terragrunt

eval "${PREFIX}() { _alias_help_all; }"





# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-05-30

### Added
- `ALIAS_SH_VERSION` variable exposed in the shell environment after sourcing
- `@ver` alias to print the current version
- `@up` alias to download the latest version from GitHub and reload the shell rc file
- `@le` alias for `less -R` (ANSI colour passthrough)
- Built-in help system: running any bare group prefix (e.g. `@g`, `@tf`) prints all aliases in that group
- `@` with no arguments lists all aliases across all groups
- Group passthrough: prefixes that wrap a base command (e.g. `@g`, `@d`) forward arguments directly to the underlying command
- `@gacp <msg>` function: add all, commit with message, and push in one command
- Full alias groups: Bash, APT, Git, Docker, Python, Node, Terraform, Terragrunt, VSCode, Windsurf, tar, TypeScript, Rust, Cargo, AWS, GCP
- Per-group prefix variables (`ALIAS_SH_GIT_PREFIX`, `ALIAS_SH_DOCKER_PREFIX`, etc.) — all namespaced with `ALIAS_SH_` to avoid conflicts
- `install.sh` — curl-pipeable installer that downloads `alias.sh` and adds a `source` line to `~/.bashrc` or `~/.zshrc`
- `README.md` with install instructions, prefix documentation, built-in help reference, and full alias table

### Changed
- All prefix control variables namespaced from `PREFIX` / `GIT_PREFIX` etc. to `ALIAS_SH_PREFIX` / `ALIAS_SH_GIT_PREFIX` etc. to prevent conflicts with `nvm` and other tools

### Fixed
- `PREFIX` environment variable conflict with `nvm` — all `ALIAS_SH_*` prefix variables are now `unset` after aliases are registered, leaving no pollution in the shell environment

# alias.sh

A small collection of terminal aliases for everyday development tasks (git, docker, apt, node, python, terraform).

## Install

### Option A: Source from bash (recommended)
Add this to your `~/.bashrc`:

```bash
source /home/robertf/develop/alias.sh/alias.sh
```

Reload your shell:

```bash
source ~/.bashrc
```

### Option B: Source from zsh
Add this to your `~/.zshrc`:

```bash
source /home/robertf/develop/alias.sh/alias.sh
```

Reload your shell:

```bash
source ~/.zshrc
```

### Option C: Source manually (one session)
```bash
source /home/robertf/develop/alias.sh/alias.sh
```

## Verify it works
```bash
alias ll
type ll
ll
```

## Common issues

### Aliases don’t persist
If you run the file like this:

```bash
./alias.sh
```

…the aliases are created in a subprocess and will not persist. Use `source alias.sh` instead.

### Aliases in scripts
Aliases typically do not expand in non-interactive shells. If you need reusable commands in scripts, prefer shell functions or standalone scripts.

## Notable aliases

### Navigation / ls
- `ll` -> `ls -la`
- `lhrt` -> `ls -lhrta`

### Git
- `g` -> `git`
- `gs` -> `git status`
- `gaa` -> `git add --all`
- `gcam` -> `git commit -am`
- `gpu` -> `git push -u origin HEAD`

### Docker
- `d` -> `docker`
- `dps` -> `docker ps`
- `dpa` -> `docker ps -a`
- `dexec` -> `docker exec`
- `dlogs` -> `docker logs`

### Apt
- `aptu` -> `sudo apt update`
- `aptug` -> `sudo apt upgrade`
- `apti` -> `sudo apt install`

### Terraform / Terragrunt
- `tf` -> `terraform`
- `tg` -> `terragrunt`

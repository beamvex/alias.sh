# alias.sh

A small collection of terminal aliases for everyday development tasks (git, docker, apt, node, python, terraform).

## Install

### Option A: curl | sh (recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/beamvex/alias.sh/main/install.sh | sh
```

This installs to `~/.config/alias.sh/alias.sh` and adds a `source` line to your `~/.bashrc` or `~/.zshrc` if it is not already present.

### Option B: Source from bash
Add this to your `~/.bashrc`:

```bash
source ~/.config/alias.sh/alias.sh
```

Reload your shell:

```bash
source ~/.bashrc
```

### Option C: Source from zsh
Add this to your `~/.zshrc`:

```bash
source ~/.config/alias.sh/alias.sh
```

Reload your shell:

```bash
source ~/.zshrc
```

### Option D: Source manually (one session)
```bash
source ~/.config/alias.sh/alias.sh
```

## Prefix

Aliases are created with a prefix. By default, the prefix is `@`.

You can override the prefix when sourcing:

```bash
PREFIX=":" source ~/.config/alias.sh/alias.sh
```

## Verify it works
```bash
alias @ll
type @ll
@ll
```

## Built-in help

Every group prefix doubles as a help command. Run it with no arguments to list all aliases in that group:

```bash
@        # Bash / navigation aliases
@apt     # APT aliases
@g       # Git aliases
@d       # Docker aliases
@p       # Python aliases
@n       # Node aliases
@tf      # Terraform aliases
@tg      # Terragrunt aliases
@aws     # AWS aliases
@gcp     # GCP aliases
```

Groups that wrap an underlying command (`@g`, `@d`, `@n`, `@p`, `@tf`, `@tg`) also act as a direct passthrough when called with arguments:

```bash
@g log --oneline -10   # same as: git log --oneline -10
@d ps -a               # same as: docker ps -a
@tf plan               # same as: terraform plan
@aws s3 ls             # same as: aws s3 ls
@gcp projects list     # same as: gcloud projects list
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

## Aliases

Run any bare prefix for a full, up-to-date list (see [Built-in help](#built-in-help) above). Quick reference below.

### Bash (`@`)
| Alias | Command |
|-------|---------|
| `@ll` | `ls -la` |
| `@lhrt` | `ls -lhrta` |
| `@le` | `less` |
| `@clr` | `clear` |

### APT (`@apt`)
| Alias | Command |
|-------|---------|
| `@aptu` | `sudo apt update` |
| `@aptug` | `sudo apt upgrade` |
| `@apti` | `sudo apt install` |
| `@aptr` | `sudo apt remove` |
| `@aptpurge` | `sudo apt purge` |
| `@aptarem` | `sudo apt autoremove` |

### Git (`@g`)
| Alias | Command |
|-------|---------|
| `@g` | `git` (passthrough) |
| `@gs` | `git status` |
| `@ga` | `git add` |
| `@gaa` | `git add --all` |
| `@gc` | `git commit` |
| `@gcam` | `git commit -am` |
| `@gacp <msg>` | add all, commit, and push |
| `@gph` | `git push` |
| `@gpu` | `git push -u origin HEAD` |
| `@gp` | `git pull` |
| `@gco` | `git checkout` |
| `@gcb` | `git checkout -b` |
| `@gi` | `git init -b main` |
| `@gl` | `git log` |

### Docker (`@d`)
| Alias | Command |
|-------|---------|
| `@d` | `docker` (passthrough) |
| `@dps` | `docker ps` |
| `@dpa` | `docker ps -a` |
| `@dstop` | `docker stop` |
| `@drm` | `docker rm` |
| `@drmi` | `docker rmi` |
| `@dexec` | `docker exec` |
| `@dlogs` | `docker logs` |
| `@dbuild` | `docker build` |
| `@dcp` | `docker-compose` |

### Python (`@p`)
| Alias | Command |
|-------|---------|
| `@p` | `python` (passthrough) |
| `@pi` | `pip3` |

### Node (`@n`)
| Alias | Command |
|-------|---------|
| `@n` | `node` (passthrough) |
| `@ni` | `npm install` |
| `@nid` | `npm install --save-dev` |
| `@nis` | `npm install --save` |
| `@ngi` | `npm install -g` |
| `@ns` | `npm start` |
| `@nd` | `npm run dev` |
| `@nr` | `npm run` |
| `@np` | `npm` |
| `@nin` | `npm init` |
| `@ny` | `yarn` |
| `@npn` | `pnpm` |

### Terraform (`@tf`)
| Alias | Command |
|-------|---------|
| `@tf` | `terraform` (passthrough) |
| `@tfi` | `terraform init` |
| `@tfp` | `terraform plan` |
| `@tfa` | `terraform apply` |
| `@tfd` | `terraform destroy` |
| `@tfv` | `terraform validate` |
| `@tfs` | `terraform show` |
| `@tfst` | `terraform state` |
| `@tfw` | `terraform workspace` |
| `@tfo` | `terraform output` |
| `@tfr` | `terraform refresh` |
| `@tft` | `terraform taint` |
| `@tfu` | `terraform untaint` |
| `@tfg` | `terraform graph` |

### Terragrunt (`@tg`)
| Alias | Command |
|-------|---------|
| `@tg` | `terragrunt` (passthrough) |

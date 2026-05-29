#!/bin/bash

# Author: Robert Forster
# Date: 2026-05-27
# Description: A collection of terminal aliases for everyday development tasks (git, docker, apt, node, python, terraform).

PREFIX="${PREFIX:-@}"

# Bash aliases
eval "alias ${PREFIX}ll=\"ls -la\""
eval "alias ${PREFIX}lhrt=\"ls -lhrta\""

eval "alias ${PREFIX}lm=\"less\""

# apt aliases
eval "alias ${PREFIX}aptu=\"sudo apt update\""
eval "alias ${PREFIX}aptug=\"sudo apt upgrade\""
eval "alias ${PREFIX}apti=\"sudo apt install\""
eval "alias ${PREFIX}aptr=\"sudo apt remove\""
eval "alias ${PREFIX}aptpurge=\"sudo apt purge\""
eval "alias ${PREFIX}aptarem=\"sudo apt autoremove\""

# Git aliases
eval "alias ${PREFIX}g=\"git\""
eval "alias ${PREFIX}gi=\"git init -b main\""
eval "alias ${PREFIX}gco=\"git checkout\""
eval "alias ${PREFIX}gcb=\"git checkout -b\""
eval "alias ${PREFIX}gs=\"git status\""
eval "alias ${PREFIX}ga=\"git add\""
eval "alias ${PREFIX}gaa=\"git add --all\""
eval "alias ${PREFIX}gc=\"git commit\""
eval "alias ${PREFIX}gcam=\"git commit -am\""
_gacp() {
  if [ "$#" -lt 1 ]; then
    echo "usage: gacp <commit message>" >&2
    return 2
  fi

  git add --all && git commit -am "$*" && git push
}
eval "alias ${PREFIX}gacp='_gacp'"
eval "alias ${PREFIX}gph=\"git push\""
eval "alias ${PREFIX}gpu=\"git push -u origin HEAD\""
eval "alias ${PREFIX}gp=\"git pull\""
eval "alias ${PREFIX}gl=\"git log\""

# Docker aliases
eval "alias ${PREFIX}d=\"docker\""
eval "alias ${PREFIX}dps=\"docker ps\""
eval "alias ${PREFIX}dpa=\"docker ps -a\""
eval "alias ${PREFIX}dstop=\"docker stop\""
eval "alias ${PREFIX}drm=\"docker rm\""
eval "alias ${PREFIX}drmi=\"docker rmi\""
eval "alias ${PREFIX}dexec=\"docker exec\""
eval "alias ${PREFIX}dlogs=\"docker logs\""
eval "alias ${PREFIX}dbuild=\"docker build\""
eval "alias ${PREFIX}dcp=\"docker-compose\""

# Python aliases
eval "alias ${PREFIX}p=\"python\""
eval "alias ${PREFIX}pi=\"pip3\""

# Node aliases
eval "alias ${PREFIX}n=\"node\""
eval "alias ${PREFIX}ni=\"npm install\""
eval "alias ${PREFIX}nid=\"npm install --save-dev\""
eval "alias ${PREFIX}nis=\"npm install --save\""
eval "alias ${PREFIX}ngi=\"npm install -g\""
eval "alias ${PREFIX}ngid=\"npm install -g --save-dev\""
eval "alias ${PREFIX}ngis=\"npm install -g --save\""
eval "alias ${PREFIX}ns=\"npm start\""
eval "alias ${PREFIX}nd=\"npm run dev\""
eval "alias ${PREFIX}nr=\"npm run\""
eval "alias ${PREFIX}np=\"npm\""
eval "alias ${PREFIX}nin=\"npm init\""
eval "alias ${PREFIX}y=\"yarn\""
eval "alias ${PREFIX}pn=\"pnpm\""

# Terraform/grunt aliases
eval "alias ${PREFIX}tf=\"terraform\""
eval "alias ${PREFIX}tfi=\"terraform init\""
eval "alias ${PREFIX}tfp=\"terraform plan\""
eval "alias ${PREFIX}tfa=\"terraform apply\""
eval "alias ${PREFIX}tfr=\"terraform refresh\""
eval "alias ${PREFIX}tfo=\"terraform output\""
eval "alias ${PREFIX}tfs=\"terraform state\""
eval "alias ${PREFIX}tft=\"terraform taint\""
eval "alias ${PREFIX}tfu=\"terraform untaint\""
eval "alias ${PREFIX}tfv=\"terraform validate\""
eval "alias ${PREFIX}tfw=\"terraform workspace\""
eval "alias ${PREFIX}tfd=\"terraform destroy\""
eval "alias ${PREFIX}tfg=\"terraform graph\""
eval "alias ${PREFIX}tfs=\"terraform show\""
eval "alias ${PREFIX}tft=\"terraform taint\""
eval "alias ${PREFIX}tfu=\"terraform untaint\""
eval "alias ${PREFIX}tfv=\"terraform validate\""
eval "alias ${PREFIX}tfw=\"terraform workspace\""
eval "alias ${PREFIX}tfd=\"terraform destroy\""
eval "alias ${PREFIX}tfg=\"terraform graph\""
eval "alias ${PREFIX}tfs=\"terraform show\""

eval "alias ${PREFIX}tg=\"terragrunt\""


# Other aliases
eval "alias ${PREFIX}c=\"clear\""



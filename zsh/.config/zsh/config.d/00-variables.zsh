# Configuration
ZSH_SKIP_UPDATE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/skip_update"
ZSH_NEXT_UPDATE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/next_update"
USER_LOCAL_BIN="${XDG_DATA_HOME:-${HOME}}/.local/bin"
ZINIT_INSTALL=0
FZF_INSTALL=0
FZF_GIT_INSTALL=0
OMP_INSTALL=0

# Get OS pretty_name
while IFS='=' read -r name value; do
  export OS_NAME="$value"
done < <(head -1 /etc/os-release)

# Env variable
if [[ ":${PATH}:" != *":${USER_LOCAL_BIN}:"* ]]; then
  export PATH="${PATH}:${USER_LOCAL_BIN}"
fi

# Date for next update
if [ ! -f "$ZSH_NEXT_UPDATE" ]; then
	mkdir -p "$(dirname $ZSH_NEXT_UPDATE)"
	date -d "+10 days" +"%Y-%m-%dT%H-%M-%S%:z" > $ZSH_NEXT_UPDATE
fi

export DATE_NEXT_UPDATE="$(cat $ZSH_NEXT_UPDATE)"
export DATE_NOW_FORMAT="$(date +"%Y-%m-%dT%H-%M-%S%:z")"

# First set LANG
export LANG=fr_FR.UTF-8

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Group grant sudo access
SUDO_GROUP="sudo"

if cat /etc/group | grep -qw 'wheel'; then
	SUDO_GROUP="wheel"
fi

export EDITOR=nvim

# ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

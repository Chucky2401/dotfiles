# Import functions
. ~/.local/share/sh/scripting_func

# Configuration
ZSH_NEXT_UPDATE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/next_update"
ZINIT_INSTALL=0
FZF_INSTALL=0

if [ ! -f "$ZSH_NEXT_UPDATE" ]; then
	mkdir -p "$(dirname $ZSH_NEXT_UPDATE)"
	date -d "+10 days" +"%Y-%m-%dT%H-%M-%S%:z" > $ZSH_NEXT_UPDATE
fi

DATE_NEXT_UPDATE="$(cat $ZSH_NEXT_UPDATE)"
DATE_NOW_FORMAT="$(date +"%Y-%m-%dT%H-%M-%S%:z")"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if cat /etc/group | grep -qw 'sudo'; then
	SUDO_GROUP="sudo"
fi

if cat /etc/group | grep -qw 'wheel'; then
	SUDO_GROUP="wheel"
fi

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	ZINIT_INSTALL=1
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Set-up fzf with git if not Arch
if ! head -1 /etc/os-release | cut -d "=" -f 2 | grep -Eqw "Arch"; then
	# Set the directory for fzf
	FZF_HOME="${HOME}/.fzf"
	
	if [ ! -d "$FZF_HOME" ]; then
    FZF_INSTALL=1
		git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_HOME"
		$FZF_HOME/install --key-bindings --completion --no-update-rc
	fi
	
	if [[ $FZF_INSTALL -eq 0 && "$DATE_NEXT_UPDATE" < "$DATE_NOW_FORMAT" ]]; then
		nohup git -C "$FZF_HOME" fetch &> /dev/null ; git -C "$FZF_HOME" pull &> /dev/null ; $FZF_HOME/install --key-bindings --completion --no-update-rc &> /dev/null 
	fi
fi

# fzf git
FZF_GIT_HOME="${HOME}/.fzf-git"

if [ ! -d "$FZF_GIT_HOME" ]; then
	git clone https://github.com/junegunn/fzf-git.sh.git "$FZF_GIT_HOME"
fi

if [[ -d "$FZF_GIT_HOME" && "$DATE_NEXT_UPDATE" < "$DATE_NOW_FORMAT" ]]; then
	nohup git -C "$FZF_GIT_HOME" fetch &> /dev/null ; git -C "$FZF_GIT_HOME" pull &> /dev/null
fi

# Oh-my-posh
OMP_DIR="/usr/local/bin/oh-my-posh"
if [ ! -f /usr/local/bin/oh-my-posh ]; then
	if groups "$USER" | grep -qw "$SUDO_GROUP"; then
	    curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin
	else
	    echo "** You are not a member of '$SUDO_GROUP' group. You must install manually oh-my-posh with root permission."
	    echo "** Here the command to use as root: 'curl -s https://ohmyposh.dev/install.sh | bash -s'"
	    echo "Press [Enter] to continue ..." ; read dummy
	fi
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
if [[ $ZINIT_INSTALL -eq 0 && "$DATE_NEXT_UPDATE" < "$DATE_NOW_FORMAT" ]]; then
	echo "Update zinit..."
	zinit self-update &> /dev/null
	zinit update &> /dev/null
	date -d "+10 days" +"%Y-%m-%dT%H-%M-%S" > $ZSH_NEXT_UPDATE
fi

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/mytheme.omp.json)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Useless if PuTTy set with 'xterm' for Home and End keys
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

# Set alias for Debian-based image distribution
if head -1 /etc/os-release | cut -d "=" -f 2 | grep -Eqw "Debian|Ubuntu"; then
  alias bat="batcat"
fi

alias ls="eza --group-directories-first -l --no-filesize --icons=always --no-time --no-user --no-permissions"

if [[ $(uname -m) = "aarch64" ]]; then
  alias ll="eza --group-directories-first -lgh --icons=always"
else
  alias ll="eza --group-directories-first -lgh --git --icons=always"
fi

alias la="ll -a"
alias susu="sudo su -"
alias vi="nvim"
alias lg="lazygit"

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

# FZF customisation
if which fdfind > /dev/null; then
	FD_BINARY=$(which fdfind | rev | cut -d'/' -f 1 | rev)
else
	FD_BINARY=$(which fd | rev | cut -d'/' -f 1 | rev)
fi

# Use fd instead of find
export FZF_DEFAULT_COMMAND="$FD_BINARY --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FD_BINARY --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
	"$FD_BINARY" --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
	"$FD_BINARY" --type=d --hidden --exclude .git . "$1"
}

source ${FZF_GIT_HOME}/fzf-git.sh

# Preview with fzf
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)           fzf --preview 'eza --tree --color=always | head -200' "$@";;
		export|unset) fzf --preview "eval 'echo \$' {}" "$@";;
		ssh)          fzf --preview 'dig {}' "$@" ;;
		*)            fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
	esac
}

# If in WSL
if [[ $(uname -r) =~ "-microsoft-.+-WSL" ]]; then
  export GPG_TTY=$(tty)
fi

# Import ssh key
if ! ssh-add -l &> /dev/null; then
  eval $(ssh-agent) &> /dev/null
  ssh-add -k
fi

# Import custom functions
for script in ~/.local/share/sh/*.sh ; do
  if [ -r "$script" ] ; then
    . "$script"
  fi
done
unset script

clear

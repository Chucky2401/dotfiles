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

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

# Docker autocompletion
if type docker &>/dev/null; then
  source <(docker completion zsh)
fi

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

# Fix for GPG
export GPG_TTY=$(tty)

# Start SSH Agent
start_ssh_agent

unset script
unset ZSH_NEXT_UPDATE ZINIT_INSTALL FZF_INSTALL FZF_GIT_INSTALL
unset DATE_NEXT_UPDATE DATE_NOW_FORMAT
unset OMP_DIR OMP_FULL_PATH
unset DATE_NEXT_UPDATE
unset DATE_NOW_FORMAT
unset OS_NAME

# Zoxide
if type zoxide &>/dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

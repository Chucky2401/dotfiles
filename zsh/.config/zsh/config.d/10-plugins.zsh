# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  message "Install Zinit"
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Set-up fzf with git if not Arch
if [[ "$OS_NAME" != "Arch" ]]; then
	# Set the directory for fzf
	FZF_HOME="${HOME}/.fzf"
	
	if [ ! -d "$FZF_HOME" ]; then
    message "Install fzf from Git repository"
    FZF_INSTALL=1
		git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_HOME"
		$FZF_HOME/install --key-bindings --completion --no-update-rc
	fi
	
	if [[ $FZF_INSTALL -eq 0 && "$DATE_NEXT_UPDATE" < "$DATE_NOW_FORMAT" ]]; then
    message "Update fzf from Git repository"
		nohup git -C "$FZF_HOME" fetch &> /dev/null ; git -C "$FZF_HOME" pull &> /dev/null ; $FZF_HOME/install --key-bindings --completion --no-update-rc &> /dev/null 
	fi
fi

# fzf git
FZF_GIT_HOME="${HOME}/.fzf-git"

if [ ! -d "$FZF_GIT_HOME" ]; then
  message "Install fzf-git"
  FZF_GIT_INSTALL=1
	git clone https://github.com/junegunn/fzf-git.sh.git "$FZF_GIT_HOME"
fi

if [[ $FZF_GIT_INSTALL -eq 0 && "$DATE_NEXT_UPDATE" < "$DATE_NOW_FORMAT" ]]; then
  message "Update fzf-git"
	nohup git -C "$FZF_GIT_HOME" fetch &> /dev/null ; git -C "$FZF_GIT_HOME" pull &> /dev/null
fi

# Zoxide for Debian or Ubuntu system only
install_zoxide

# Oh-my-posh
install_ohmyposh

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
if [[ "$DATE_NEXT_UPDATE" < "$DATE_NOW_FORMAT" ]]; then
	message "Update Zinit"
	zinit self-update &> /dev/null
	zinit update &> /dev/null
	date -d "+10 days" +"%Y-%m-%dT%H-%M-%S" > $ZSH_NEXT_UPDATE
fi

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit

zinit cdreplay -q

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/mytheme.omp.json)"

# Atuin
if type atuin &>/dev/null; then
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
fi

if type terraform; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/bin/terraform terraform
fi

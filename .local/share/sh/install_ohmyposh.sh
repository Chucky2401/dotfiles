version_lessthan() {
	! printf "%s\n%s" "$2" "$1" | sort -CV
}

install_ohmyposh() {
  if [[ $(id -u) -ne 0 ]]; then
    message "Install/Update Oh-My-Posh (which may request your password)..."
    export COMMON_FUNCTIONS=$(readlink -f ~/.local/share/sh/scripting_func)
    FUNCTIONS=$(declare -f version_lessthan install_ohmyposh)
    execute_sudo "--preserve-env" "bash" "-c" "$FUNCTIONS; install_ohmyposh"
    return
  fi

  . "$COMMON_FUNCTIONS"

	OMP_SETUP_FOLDER="/usr/local/bin"
  OMP_PATH="$OMP_SETUP_FOLDER/oh-my-posh"
  OMP_INSTALL_FOLDER="/opt/ohmyposh"
  OMP_INSTALL_FILE="$OMP_INSTALL_FOLDER/install.sh"
	OMP_VERSION_GIT=$(curl -s "https://api.github.com/repos/jandedobbeleer/oh-my-posh/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

	OMP_VERSION_INSTALLED="0.0.0"
	
	if [[ ! -d "$OMP_SETUP_FOLDER" ]]; then
		mkdir $OMP_SETUP_FOLDER
	fi
	
	if [[ -d "$OMP_SETUP_FOLDER" && -f "$OMP_PATH" ]]; then
		OMP_VERSION_INSTALLED=$(oh-my-posh version)
	fi

  if [[ "$OMP_VERSION_INSTALLED" == "0.0.0" ]]; then
    if [[ ! -d "$OMP_INSTALL_FOLDER" ]]; then
      mkdir -p "$OMP_INSTALL_FOLDER"
    fi

    if [[ ! -e "$OMP_INSTALL_FILE" ]]; then
      curl -sLo "$OMP_INSTALL_FILE" https://ohmyposh.dev/install.sh
      chmod +x "$OMP_INSTALL_FILE"
    fi

    execute "$OMP_INSTALL_FILE" "-d" "$OMP_SETUP_FOLDER"
    exit 0
  fi
	
	if version_lessthan "$OMP_VERSION_INSTALLED" "$OMP_VERSION_GIT"; then
		# curl -Lo /opt/lazygit/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION_GIT}_Linux_${ARCH}.tar.gz"
		# tar xf /opt/lazygit/lazygit.tar.gz -C /opt/lazygit/ lazygit
		# sudo install -Dm 755 /opt/lazygit/lazygit -t /usr/local/bin
		# rm -f /opt/lazygit/lazygit*
		# echo "$LAZYGIT_VERSION_GIT" > /opt/lazygit/last_version
    execute_sudo "oh-my-posh upgrade"
	fi
}


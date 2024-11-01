version_lessthan() {
	! printf "%s\n%s" "$2" "$1" | sort -CV
}

install_lazygit() {
  if [[ $(id -u) -ne 0 ]]; then
    message "Install Lazygit (which may request your password)..."
    FUNCTIONS=$(declare -f version_lessthan install_lazygit)
    execute_sudo "bash" "-c" "$FUNCTIONS; install_lazygit"
    return
  fi

	ARCH=$(uname -m)
	if [ "$ARCH" = "aarch64" ]; then
		ARCH="arm64"
	fi
	
	LG_SETUP_FOLDER="/opt/lazygit/"
	LAZYGIT_VERSION_GIT=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*' > /dev/null 2>&1)

	LAZYGIT_VERSION_INSTALLED="0.0.0"
	
	if [[ ! -d "$LG_SETUP_FOLDER" ]]; then
		mkdir $LG_SETUP_FOLDER
	fi
	
	if [[ -d "$LG_SETUP_FOLDER" && -f /opt/lazygit/last_version ]]; then
		LAZYGIT_VERSION_INSTALLED=$(cat /opt/lazygit/last_version)
	fi
	
	if version_lessthan "$LAZYGIT_VERSION_INSTALLED" "$LAZYGIT_VERSION_GIT"; then
		curl -Lo /opt/lazygit/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION_GIT}_Linux_${ARCH}.tar.gz"
		tar xf /opt/lazygit/lazygit.tar.gz -C /opt/lazygit/ lazygit
		sudo install -Dm 755 /opt/lazygit/lazygit -t /usr/local/bin
		rm -f /opt/lazygit/lazygit*
		echo "$LAZYGIT_VERSION_GIT" > /opt/lazygit/last_version
	fi
}


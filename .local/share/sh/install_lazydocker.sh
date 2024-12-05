version_lessthan() {
	! printf "%s\n%s" "$2" "$1" | sort -CV
}

install_lazydocker() {
  if [[ $(id -u) -ne 0 ]]; then
    message "Install/Update Lazydocker (which may request your password)..."
    FUNCTIONS=$(declare -f version_lessthan install_lazydocker)
    execute_sudo "bash" "-c" "$FUNCTIONS; install_lazydocker"
    return
  fi

	ARCH=$(uname -m)
	if [ "$ARCH" = "aarch64" ]; then
		ARCH="arm64"
	fi
	
	LD_SETUP_FOLDER="/opt/lazydocker/"
	LAZYDOCKER_VERSION_GIT=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	LAZYDOCKER_VERSION_INSTALLED="0.0.0"
	
	if [[ ! -d "$LD_SETUP_FOLDER" ]]; then
		mkdir -p $LD_SETUP_FOLDER
	fi
	
	if [[ -d "$LD_SETUP_FOLDER" && -f /opt/lazydocker/last_version ]]; then
		LAZYDOCKER_VERSION_INSTALLED=$(cat /opt/lazydocker/last_version)
	fi

  echo "Git version : ${LAZYDOCKER_VERSION_GIT}"
  echo "Local version: ${LAZYDOCKER_VERSION_INSTALLED}"
	
	if version_lessthan "$LAZYDOCKER_VERSION_INSTALLED" "$LAZYDOCKER_VERSION_GIT"; then
    echo "==> URL: https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION_GIT}_Lnux_${ARCH}.tar.gz"
		curl -sLo /opt/lazydocker/lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION_GIT}_Linux_${ARCH}.tar.gz"
		tar xf /opt/lazydocker/lazydocker.tar.gz -C /opt/lazydocker/ lazydocker
		install -Dm 755 /opt/lazydocker/lazydocker -t /usr/local/bin
		rm -f /opt/lazydocker/lazydocker*
		echo "$LAZYDOCKER_VERSION_GIT" > /opt/lazydocker/last_version
	fi
}


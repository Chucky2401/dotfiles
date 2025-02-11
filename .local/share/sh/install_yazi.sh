version_lessthan() {
	! printf "%s\n%s" "$2" "$1" | sort -CV
}

install_yazi() {
  if [[ $(id -u) -ne 0 ]]; then
    message "Install/Update YaZi (which may request your password)..."
    FUNCTIONS=$(declare -f version_lessthan install_yazi)
    execute_sudo "bash" "-c" "$FUNCTIONS; install_yazi"
    return
  fi

	ARCH=$(uname -m)
#	if [ "$ARCH" = "aarch64" ]; then
#		ARCH="arm64"
#	fi
	
	YZ_SETUP_FOLDER="/usr/local/bin"
  YZ_ARCHIVE_NAME="yazi-${ARCH}-unknown-linux-musl"
	YAZI_VERSION_GIT=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

	YAZI_VERSION_INSTALLED="0.0.0"
	
	if [[ -f /usr/local/bin/yazi ]]; then
		YAZI_VERSION_INSTALLED=$(yazi -V | grep -Po '\d+\.\d+\.\d+')
	fi
	
	if version_lessthan "$YAZI_VERSION_INSTALLED" "$YAZI_VERSION_GIT"; then
		curl -sLo /tmp/yazi.zip "https://github.com/sxyazi/yazi/releases/latest/download/${YZ_ARCHIVE_NAME}.zip"
    unzip /tmp/yazi.zip -d /tmp/
		sudo install -D /tmp/${YZ_ARCHIVE_NAME}/ya* -t /usr/local/bin/
		rm -rf /tmp/yazi.zip /tmp/${YZ_ARCHIVE_NAME}
	fi
}


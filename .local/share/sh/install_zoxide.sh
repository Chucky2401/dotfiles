function install_zoxide() {
  if ! [[ "$OS_NAME" =~ "Debian|Ubuntu" ]]; then
    return
  fi

  if type zoxide &>/dev/null && ! [[ "$DATE_NEXT_UPDATE" < "$DATE_NOW_FORMAT" ]]; then
    return
  fi

  if [[ $(id -u) -ne 0 ]]; then
    message "Install/Update Zoxide (which may request your password)..."
    FUNCTIONS=$(declare -f version_lessthan install_zoxide)
    execute_sudo "-E" "zsh" "-c" "$FUNCTIONS; install_zoxide"
    return
  fi

  ZOXIDE_SETUP_FOLDER="/usr/local/bin"
  ZOXIDE_MAN_FOLDER="/usr/share/man"

  ZOXIDE_VERSION_INSTALLED="0.0.0"
  ZOXIDE_VERSION_GIT=$(curl -s "https://api.github.com/repos/ajeetdsouza/zoxide/releases/latest" |
    grep -Po '"tag_name": "v\K[^"]*')

  if type zoxide &>/dev/null; then
    ZOXIDE_VERSION_INSTALLED=$(zoxide --version | cut -d ' ' -f 2)
  fi

  if version_lessthan "$ZOXIDE_VERSION_INSTALLED" "$ZOXIDE_VERSION_GIT"; then
    BINARY_LOG_FILE=$(mktemp)
    nohup curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh |
      sh -s -- --bin-dir "$ZOXIDE_SETUP_FOLDER" --man-dir "$ZOXIDE_MAN_FOLDER" &>"$BINARY_LOG_FILE"
  fi
}

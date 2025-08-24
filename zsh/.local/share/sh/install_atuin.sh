function install_atuin() {
  ATUIN_VERSION_INSTALLED="0.0.0"
  ATUIN_VERSION_GIT=$(curl -s "https://api.github.com/repos/atuinsh/atuin/releases/latest" |
    grep -Po '"tag_name": "v\K[^"]*')

  if type atuin &>/dev/null; then
    ATUIN_VERSION_INSTALLED=$(atuin --version | cut -d ' ' -f 2)
  fi

  if version_lessthan "$ATUIN_VERSION_INSTALLED" "$ATUIN_VERSION_GIT"; then
    INSTALL_LOG_FILE=$(mktemp)
    nohup curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh |
      sh &>"$INSTALL_LOG_FILE"
  fi
}

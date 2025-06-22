install_ohmyposh() {
  if [[ $(id -u) -ne 0 ]]; then
    message "Install/Update Oh-My-Posh (which may request your password)..."
    export COMMON_FUNCTIONS=$(readlink -f ~/.local/share/sh/_scripting_func.sh)
    FUNCTIONS=$(declare -f install_ohmyposh)

    execute_sudo "-E" "zsh" "-c" "$FUNCTIONS; install_ohmyposh"
    execute_sudo "zsh" "-c" "chown -R $(id -u):$(id -u) $(echo ~/.cache/oh-my-posh/)"

    unset COMMON_FUNCTIONS

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
    return
  fi

  if version_lessthan "$OMP_VERSION_INSTALLED" "$OMP_VERSION_GIT"; then
    execute "oh-my-posh" "upgrade"
  fi
}

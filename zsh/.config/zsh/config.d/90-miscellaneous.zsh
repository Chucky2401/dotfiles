# Link batcat
if [[ "$OS_NAME" =~ "Debian|Ubuntu" && -f /usr/bin/batcat && ! -e ~/.local/bin/bat ]]; then
  if [[ -d "~/.local/bin" ]]; then
    mkdir ~/.local/bin
  fi

  ln -s /usr/bin/batcat ~/.local/bin/bat
fi

# Fortune with cowsay
# Because is funny
if type fortune &>/dev/null && type cowsay &>/dev/null && type lolcat &>/dev/null; then
  fortune -a -n 10 | cowsay | lolcat
fi

unset script
unset ZSH_NEXT_UPDATE ZINIT_INSTALL FZF_INSTALL FZF_GIT_INSTALL
unset DATE_NEXT_UPDATE DATE_NOW_FORMAT
unset OMP_DIR OMP_FULL_PATH
unset DATE_NEXT_UPDATE
unset DATE_NOW_FORMAT
unset OS_NAME

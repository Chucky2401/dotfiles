# Fortune with cowsay
# Because is funny
if type fortune &>/dev/null && type cowsay &>/dev/null && type lolcat &>/dev/null; then
  fortune -a | cowsay | lolcat
fi

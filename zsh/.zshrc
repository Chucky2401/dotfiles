# Import custom functions
# From the git repo
for script in $(find ~/.local/share/sh/ -name "*.sh") ; do
  if [ -r "$script" ] ; then
    . "$script"
  fi
done
unset script

# Only on local machine
for script in $(find ~/.local/ -maxdepth 1 -type f -name "*.sh") ; do
  if [ -r "$script" ] ; then
    . "$script"
  fi
done
unset script

# Load config files
for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

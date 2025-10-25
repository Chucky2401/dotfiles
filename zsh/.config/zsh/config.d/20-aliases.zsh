# Set alias for Debian-based image distribution
if [[ "$OS_NAME" =~ "Debian|Ubuntu" ]]; then
  alias bat="batcat"
fi

alias ls="eza --group-directories-first -l --no-filesize --icons=always --no-time --no-user --no-permissions"

if [[ $(uname -m) = "aarch64" ]]; then
  alias ll="eza --group-directories-first -lgh --icons=always"
else
  alias ll="eza --group-directories-first -lgh --git --icons=always"
fi

# Quotidien
alias la="ll -a"
alias llt="ll --sort=modified"
alias lltr="ll --sort=oldest"
alias lat="la --sort=modified"
alias latr="la --sort=oldest"

alias susu="sudo su -"
alias vi="nvim"
alias lg="lazygit"

# Utile
alias ld="lazydocker"
alias fman="compgen -c | fzf | xargs man"
alias dfh="echo "" ; df -h | tail -n +2 | column -t -N Device,Size,Used,Available,\"Used %\",Mountpoint ; echo"
alias cleardns="resolvectl flush-caches"
alias weather="curl wttr.in/Saint-Jean-Pla-De-Corts"

# Alias Docker Pi3
alias syncpi3='rsync -avze "ssh -p 666" /home/docker_pi3/* --progress blackwizard@192.168.1.40:/home/docker/'
alias synchp='rsync -avze "ssh -p 666" /home/docker_hp/* --progress blackwizard@192.168.1.250:/home/docker/'

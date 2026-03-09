function fm() {
  BAT_BIN="bat"
  if ! [[ "$OS_NAME" =~ "Debian|Ubuntu" ]]; then
    BAT_BIN="batcat"
  fi
  /usr/bin/man -k . | awk '{printf "%s:%s", $1, gensub(/\(|\)/,"","g",$2); printf "\n"}' | sort | fzf \
    --delimiter=':' \
    --with-nth '{1}.{2}' \
    --preview "man {2} {1} | ${BAT_BIN} -l man -p" \
    --bind "enter:become(man {2} {1} | ${BAT_BIN} -l man -p)"
}

function mn() {
  if [[ -z "$1" ]]; then
    return
  fi

  /usr/bin/man $1 | bat -l man -p
}

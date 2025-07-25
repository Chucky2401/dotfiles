function conn_ssh() {
  while read -r client; do
    INFO=$(ssh -Gt "$client" 2>/dev/null | grep -E "^user |port " | tr '\n' ';' | sed 's/;$//')
    printf "%s:%s\n" "$client" "$INFO"
  done < <(grep -P "^Host ([^*]+)$" ~/.ssh/config | sed 's/Host //' | sort) | fzf --tmux center \
    --prompt ' ' \
    --pointer '󰛂' \
    --border-label ' SSH Servers ' \
    --delimiter=':' \
    --with-nth '{1}' \
    --preview 'echo {2} | sed "s/;/\n/"' \
    --bind 'enter:become(ssh {1})'
}

bindkey -s '^g^n' 'conn_ssh\n'

function conn_ssh() {
  while read -r client; do
    INFO=$(ssh -Gt "$client" 2>/dev/null |
      grep -E "^user |^port |^hostname " |
      sort |
      tr '\n' ';' |
      sed 's/;$//')
    printf "%s:%s\n" "$client" "$INFO"
  done < <(grep -P "^Host ([^*]+)$" ~/.ssh/config | sed 's/Host //' | sort) | fzf --tmux center \
    --prompt ' ' \
    --pointer '󰛂' \
    --border-label ' SSH Servers ' \
    --delimiter=':' \
    --with-nth '{1}' \
    --preview 'echo {2} | sed "s/;/\n/g"' \
    --bind 'enter:become(ssh {1})'
}

function conn_telnet() {
  LIST_CONNEXION=$(
    cat <<EOF
Alberes:hostname alberes.sterimed.local:telnet alberes.sterimed.local
Valespir:hostname valespir.sterimed.local:telnet valespir.sterimed.local
EOF
  )

  echo "$LIST_CONNEXION" | fzf --tmux center \
    --prompt ' ' \
    --pointer '󰛂' \
    --border-label ' SSH Servers ' \
    --delimiter=':' \
    --with-nth '{1}' \
    --preview 'echo {2}' \
    --bind 'enter:become(telnet $(echo {2} | sed "s/hostname //"))'
}

bindkey -M viins -s '^g^n' 'conn_ssh\n'
bindkey -M viins -s '^g^a' 'conn_telnet\n'

function _forti_wrapper() {
  trap "trap -; tput rmcup; return" 2
  # trap "printf '\e[?1049l'; return" SIGINT
  sleep=3

  while getopts "s:" opt; do
    case "$opt" in
    s)
      sleep=${OPTARG}
      ;;
    esac
  done

  shift $((OPTIND - 1))

  STD_REGEX="--user=tbrejon"
  ADM_REGEX="--user=adm_"

  tput smcup
  clear

  if [[ "$@" =~ $STD_REGEX ]]; then
    message "Connexion compte standard..."
  fi

  if [[ "$@" =~ $ADM_REGEX ]]; then
    message "Connexion compte ADM..."
  fi

  $@

  sleep ${sleep}
  tput rmcup
  trap -
}

function vpn() {
  LIST_COMMAND=$(
    cat <<EOF
fortiadmstart:ADM Start:Start VPN with ADM account
fortistart:STD Start:Start VPN with standard account
fortistop:Stop:Stop current VPN connection
fortireset:Reset:Reset current VPN connection
fortiswitch:Switch:Switch VPN to the other account
vpnstatus:Status:Display continuously the VPN status
EOF
  )

  # listAliases=$(alias | grep -E "^forti" | cut -d = -f 1)
  # listFuncs=$(typeset -f | grep -E "^forti" | sed -E 's/ |\(|\)|\{//g')

  # cmd=$(echo "${listAliases}\n${listFuncs}" | grep -E "^forti" | fzf --tmux center)
  cmd=$(
    echo "$LIST_COMMAND" | fzf --tmux center \
      --prompt '󰖂  ' \
      --pointer '󰛂' \
      --border-label ' FortiClient Operations ' \
      --delimiter=':' \
      --with-nth '{2}' \
      --preview-window=up,wrap,20% \
      --preview 'echo {3}' \
      --bind 'enter:become(echo {1})'
  )

  eval "$cmd"
}

alias fortistart='_forti_wrapper forticlient vpn connect 0_Palalda --user=tbrejon --password'
alias fortiadmstart='_forti_wrapper forticlient vpn connect 0_Palalda --user=adm_tbrejon --password'
alias fortistatus='forticlient vpn status'
alias fortistop='forticlient vpn disconnect'

bindkey -s '^g^v' 'vpn\n'

function fortiswitch() {
  currentUser=$(fortistatus | grep Username | cut -d ":" -f 2 | xargs)

  tput smcup
  clear

  if [[ "$currentUser" == "adm_tbrejon" ]]; then
    message "Bascule sur le compte standard..."
    fortistop && fortistart
    return
  fi

  if [[ "$currentUser" == "tbrejon" ]]; then
    message "Bascule sur le compte ADM..."
    fortistop && fortiadmstart
    return
  fi

  message "Vous n'êtes pas connecté au vpn"

  sleep 3
  tput rmcup
}

function fortireset() {
  currentUser=$(fortistatus | grep Username | cut -d ":" -f 2 | xargs)

  tput smcup
  clear

  if [[ "$currentUser" == "adm_tbrejon" ]]; then
    message "Reset connexion ADM..."
    fortistop && fortiadmstart
    return
  fi

  if [[ "$currentUser" == "tbrejon" ]]; then
    message "Reset connexion standard..."
    fortistop && fortistart
    return
  fi

  message "Vous n'êtes pas connecté au vpn"
}

function vpnstatus() {
  local begin=1
  run=1
  sleep=2

  while getopts "s:" opt; do
    case "$opt" in
    s)
      sleep=${OPTARG}
      ;;
    esac
  done

  shift $((OPTIND - 1))

  trap "run=0" SIGINT

  defaultColor=$(tput sgr0)

  blackFgColor=$(tput setaf 0)
  redFgColor=$(tput setaf 1)
  greenFgColor=$(tput setaf 2)
  yellowFgColor=$(tput setaf 3)
  blueFgColor=$(tput setaf 4)

  redBgColor=$(tput setab 1)

  boldText=$(tput bold)

  while [[ $run -eq 1 ]]; do
    # Another instance of this program is running.
    statusIsRunning="Another instance of this program is running."
    statusObject=$(fortistatus)
    isRunning=$(echo "$statusObject" | grep "${statusIsRunning}")
    statusVpn=$(echo "$statusObject" | grep "Status" | cut -d ":" -f 2 | xargs)
    username=$(echo "$statusObject" | grep "Username" | cut -d ":" -f 2 | xargs)
    duration=$(echo "$statusObject" | grep "Duration" | cut -d ":" -f 2-4 | xargs)

    statusUnknow=0

    if [[ "$statusVpn" != "Not Running" ]] && [[ "$isRunning" != "${statusIsRunning}" ]]; then
      statusUnknow=1
    fi

    if [[ "$isRunning" == "${statusIsRunning}" ]]; then
      statusVpn="Connecting..."
    fi

    if [[ -z "$statusVpn" ]] && [[ "$isRunning" != "${statusIsRunning}" ]]; then
      statusVpn="#N/A"
    fi

    if [[ -z "$username" ]] && [[ "$statusUnknow" -eq 1 ]]; then
      username="#N/A"
    fi

    if [[ -z "$duration" ]] && [[ "$statusUnknow" -eq 1 ]]; then
      duration="#N/A"
    fi

    tput smcup
    clear

    echo -n "${boldText}Status actuel du VPN${defaultColor} :\n\n"

    if [[ "${statusVpn}" == "Connected" ]]; then
      echo -n "Status:   ${greenFgColor}${statusVpn}${defaultColor}\n"
    elif [[ "$statusVpn" == "#N/A" ]]; then
      echo -n "Status:   ${boldText}${blackFgColor}${redBgColor}${statusVpn}${defaultColor}\n"
    elif [[ "$statusVpn" == "Connecting..." ]]; then
      echo -n "Status:   ${blueFgColor}${statusVpn}${defaultColor}\n"
    else #Not Running
      echo -n "Status:   ${redFgColor}${statusVpn}${defaultColor}\n"
    fi

    if [[ "$username" == "#N/A" ]]; then
      echo -n "Username: ${boldText}${blackFgColor}${redBgColor}${username}${defaultColor}\n"
    else
      echo -n "Username: ${blueFgColor}${username}${defaultColor}\n"
    fi

    if [[ "$duration" == "#N/A" ]]; then
      echo -n "Duration: ${boldText}${blackFgColor}${redBgColor}${duration}${defaultColor}\n"
    else
      echo -n "Duration: ${yellowFgColor}${duration}${defaultColor}\n"
    fi

    sleep ${sleep}
  done

  tput rmcup
}

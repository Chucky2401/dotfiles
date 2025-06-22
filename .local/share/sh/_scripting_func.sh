unset HAVE_SUDO_ACCESS

# String formatter
if [[ -t 1 ]]; then
  shell_escape() { printf "\033[%sm" "$1"; }
else
  shell_escape() { :; }
fi

shell_make_bold() { shell_escape "1;$1"; }
shell_make_bold_italic() { shell_escape "1;3;$1"; }

shell_underline="$(shell_escape "4;39")"
shell_blue="$(shell_make_bold 34)"
shell_red="$(shell_make_bold 31)"
shell_green="$(shell_make_bold 32)"
shell_bold="$(shell_make_bold 39)"
shell_bold_italic="$(shell_make_bold_italic 39)"
shell_reset="$(shell_escape 0)"

# Abort script
abort() {
  printf "[ABORTED] %s\n" "$@" >&2
  # exit 1
}

# Join arguments
shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"; do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

# chomp() {
#   printf "%s" "${1/"$'\n'"/}"
# }

# Print informative message
message() {
  printf "${shell_blue}==>${shell_bold} %s${shell_reset}\n" "$(shell_join "$@")"
}

success_message() {
  printf "${shell_green}==>${shell_bold} %s${shell_reset}\n" "$(shell_join "$@")"
}

error_message() {
  printf "${shell_red}==>${shell_bold} %s${shell_reset}\n" "$(shell_join "$@")"
}

execute() {
  if ! "$@"; then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

execute_sudo() {
  local -a args=("$@")
  if [[ "${EUID:-${UID}}" != "0" ]] && have_sudo_access; then
    if [[ -n "${SUDO_ASKPASS-}" ]]; then
      args=("-A" "${args[@]}")
    fi
    execute "/usr/bin/sudo" "${args[@]}"
  else
    message "${args[@]}"
    execute "${args[@]}"
  fi
}

have_sudo_access() {
  if [[ ! -x "/usr/bin/sudo" ]]; then
    return 1
  fi

  local -a SUDO=("/usr/bin/sudo")
  if [[ -n "${SUDO_ASKPASS-}" ]]; then
    SUDO+=("-A")
  fi

  if [[ -z "${HAVE_SUDO_ACCESS-}" ]]; then
    HAVE_SUDO_ACCESS="$?"
  fi

  if [[ "${HAVE_SUDO_ACCESS}" -ne 0 ]]; then
    abort "Need sudo access on macOS (e.g. the user ${USER} needs to be an Administrator)!"
  fi

  return "${HAVE_SUDO_ACCESS}"
}

version_lessthan() {
  ! printf "%s\n%s" "$2" "$1" | sort -CV
}

ensure() {
  if ! "$@"; then abort "command failed: $*"; fi
}

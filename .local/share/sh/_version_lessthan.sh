version_lessthan() {
  ! printf "%s\n%s" "$2" "$1" | sort -CV
}

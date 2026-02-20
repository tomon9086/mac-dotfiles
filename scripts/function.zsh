function gibo() {
	if [ -z "$2" ] &&  [ "dump" = "$1" ]; then
		command gibo list | sed -e 's/=== .\+ ===//g' | sed -e 's/\s\+/\n/g' | grep -v '^\s*$' | fzy | xargs -I@ gibo dump @
	else
		command gibo $*
	fi
}

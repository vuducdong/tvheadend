#!/bin/sh
# Entrypoint for tvheadend-iptv-lite.
#   TVH_CONFIG  config directory (default /config)
#   TVH_ARGS    extra tvheadend arguments (e.g. "--noacl --http_port 9981")
# Any arguments passed to the container (RouterOS "cmd=") are forwarded to tvheadend.
set -eu

CONFIG="${TVH_CONFIG:-/config}"
mkdir -p "${CONFIG}"

# If the first argument is an executable in PATH (e.g. "sh"), run it instead of tvheadend.
if [ "${#}" -gt 0 ] && [ "${1#-}" = "${1}" ] && command -v "${1}" >/dev/null 2>&1; then
	exec "${@}"
fi

# shellcheck disable=SC2086
exec tvheadend -c "${CONFIG}" -B ${TVH_ARGS:-} "${@}"

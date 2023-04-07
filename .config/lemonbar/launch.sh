#!/usr/bin/env bash

. "${HOME}/.cache/wal/colors.sh"

pkill lemonbar

~/.config/lemonbar/lemonbar-content.sh | lemonbar -p -B "$color0" -F "$color15"

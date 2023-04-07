#!/usr/bin/env bash

. "${HOME}/.cache/wal/colors.sh"


Workspaces() {
	ACTIVE=$(bspc query -D -d .active --names)
		
	for WORKSPACE in $(bspc query -D --names)
	do
		if [ $ACTIVE = $WORKSPACE ] 
		then
			printf "%%{B$color1} $WORKSPACE %%{B-}"
		else
			printf " $WORKSPACE "
		fi
	done

}

Clock() {
        DATETIME=$(date "+%a %b %d, %T")
        printf "$DATETIME"
}

Root() {
	ROOT=$(df -h / | grep / | awk '{print $4}')
	printf "$ROOT"
}

Cpu() {
	CPU=$(top -bn 1 | grep "%Cpu" | awk '{print 100-$8}')
	printf "%5.2f" "$CPU"
}

Volume() {
	VOLUME=$(amixer | grep "Front Right:" | awk '{print $5}' | sed 's/\[//g' | sed 's/\%\]//g')
	printf "$VOLUME"
}



# Print Output 
while true; do
	echo "%{l}$(Workspaces) %{r}ROOT: $(Root) | CPU: $(Cpu) | VOL: $(Volume) | $(Clock)" 
        sleep 1
done

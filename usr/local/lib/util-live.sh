#!/bin/bash
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

kernel_cmdline(){
	for param in $(cat /proc/cmdline); do
		case "${param}" in
			$1=*) echo "${param##*=}"; return 0 ;;
			$1) return 0 ;;
			*) continue ;;
		esac
	done
	[ -n "${2}" ] && echo "${2}"
	return 1
}

get_lang(){
	echo $(kernel_cmdline lang)
}

get_keytable(){
	echo $(kernel_cmdline keytable)
}

get_tz(){
	echo $(kernel_cmdline tz)
}

get_timer_ms(){
	echo $(date +%s%3N)
}

# $1: start timer
elapsed_time_ms(){
	echo $(echo $1 $(get_timer_ms) | awk '{ printf "%0.3f",($2-$1)/1000 }')
}

configure_language(){
    # hack to be able to set the locale on bootup
    local lang=$(get_lang)
    keytable=$(get_keytable)
    local timezone=$(get_tz)
    # Fallback
    [[ -z "${lang}" ]] && lang="en_US"
    [[ -z "${keytable}" ]] && keytable="us"
    [[ -z "${timezone}" ]] && timezone="Etc/UTC"

    sed -e "s/#${lang}.UTF-8/${lang}.UTF-8/" -i /etc/locale.gen

    echo "LANG=${lang}.UTF-8" >> /etc/environment

    if [[ -d /run/openrc ]]; then
        sed -i "s/keymap=.*/keymap=\"${keytable}\"/" /etc/conf.d/keymaps
    fi
    echo "KEYMAP=${keytable}" > /etc/vconsole.conf
    echo "LANG=${lang}.UTF-8" > /etc/locale.conf
    ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

    #write_x11_config

    loadkeys "${keytable}"

    locale-gen ${lang}
    echo "Configured language: ${lang}" >> /var/log/miladi-live.log
    echo "Configured keymap: ${keytable}" >> /var/log/miladi-live.log
    echo "Configured timezone: ${timezone}" >> /var/log/miladi-live.log
}


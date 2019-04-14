#!/usr/bin/env bash
# This scripts runs as root
printf ":::\t\t\t\t\t:::\n::\t\tADVPN Debug\t\t ::\n"
printf ":::\t\t\t\t\t:::\n::\tLatest Commit\t\t\t ::\n:::\t\t\t\t\t:::\n"
git --git-dir /etc/.advpn/.git log -n 1
printf ":::\t\t\t\t\t:::\n::\tRecursive list of files in\t ::\n"
printf "::\t/etc/openvpn/easy-rsa/pki\t ::\n:::\t\t\t\t\t:::\n"
ls -LR /etc/openvpn/easy-rsa/pki/ -Ireqs -Icerts_by_serial
printf ":::\t\t\t\t\t:::\n::\tOutput of /etc/advpn/*\t\t ::\n:::\t\t\t\t\t:::\n"
for filename in /etc/advpn/*; do
    if [[ "${filename}" != "/etc/advpn/install.log" ]]; then
        echo ":: START $filename ::"
        cat "$filename"
        echo ":: END $filename ::"
    fi
done
printf ":::\t\t\t\t\t:::\n:: /etc/openvpn/easy-rsa/pki/Default.txt ::\n:::\t\t\t\t\t:::\n"
cat /etc/openvpn/easy-rsa/pki/Default.txt
if [[ ${noUFW} -eq 1 ]]; then
    printf ":::\t\t\t\t\t:::\n::\tOutput of iptables\t\t ::\n:::\t\t\t\t\t:::\n"
    iptables -t nat -L -n -v
fi
printf ":::\t\t\t\t\t:::\n::\tDebug Output Complete\t\t ::\n:::\t\t\t\t\t:::\n"

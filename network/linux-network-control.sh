#!/bin/bash

# POTREBNO JE ONEMOGUĆITI MDNS SERVISE AVAHI-DAEMON ILI SYSTEMD-RESOLVED

WIFI_SUCELJE=wlp4s0
DIO_IMENA_MREZE=Iwan

# ODSPOJI SE SA MREŽE

# Odspoji se s mreže
nmcli device disconnect $WIFI_SUCELJE

# PROMIJENI MAC ADRESU

# Najviši bit
X_11=$(printf "%x" "$((RANDOM % 16))")

# Posebni lokalni unicast bit (2, 6, A, E)
X_10=$((RANDOM % 4))
((X_10 *= 4))
((X_10 += 2))
X_10=$(printf "%x" $X_10)

# Ostali niži bitovi
X_9=$(printf "%x" "$((RANDOM % 16))")
X_8=$(printf "%x" "$((RANDOM % 16))")
X_7=$(printf "%x" "$((RANDOM % 16))")
X_6=$(printf "%x" "$((RANDOM % 16))")
X_5=$(printf "%x" "$((RANDOM % 16))")
X_4=$(printf "%x" "$((RANDOM % 16))")
X_3=$(printf "%x" "$((RANDOM % 16))")
X_2=$(printf "%x" "$((RANDOM % 16))")
X_1=$(printf "%x" "$((RANDOM % 16))")
X_0=$(printf "%x" "$((RANDOM % 16))")

MAC_ADDRESS=$X_11$X_10:$X_9$X_8:$X_7$X_6:$X_5$X_4:$X_3$X_2:$X_1$X_0

echo $MAC_ADDRESS 

# Postavi MAC adresu
nmcli device modify $WIFI_SUCELJE wifi.mac-address $MAC_ADDRESS

# SPOJI SE NA MREŽU

# Izvuci BSSID
BSSID=$(nmcli device wifi list | grep -m 1 "$DIO_IMENA_MREZE" | awk -F ' ' '{print $1}')

# Spoji se pomoću BSSID-a
nmcli device wifi connect $BSSID

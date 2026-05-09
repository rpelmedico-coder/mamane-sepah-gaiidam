# Codespace VLESS Proxy

This repository provides a quick and free way to set up a personal VPN (VLESS over WebSocket) using **GitHub Codespaces**. This is particularly useful for bypassing internet censorship, as GitHub's infrastructure and domains (`*.app.github.dev`) are often unblocked.

## Instructions:

1. Click the green **"Code"** button at the top of this repository.
2. Select the **"Codespaces"** tab.
3. Click the **"Create codespace on main"** button (or the `+` icon).
4. Wait a few moments for the virtual environment to load (it looks like a code editor).
5. Look at the **Terminal** at the bottom of the screen. Type the following command and press `Enter`:
   ```
   cd v2ray_codespace
   bash run.sh
   ```
6. The system will automatically download and configure the Xray server.
7. The terminal will print a link starting with `vless://...`. **Do not copy it just yet.**
8. **⚠️ CRITICAL STEP ⚠️**: 
   - At the bottom of the screen, right next to the "TERMINAL" tab, click on the **"PORTS"** tab.
   - You will see port `8080` in the list.
   - **Right-click** on it.
   - Select **"Port Visibility"** and change it to **"Public"**.
   - *If you skip this step, the proxy will not work.*
9. Now, go back to the terminal, copy the `vless://...` link, and paste it into your VPN app:
    - **Android:** v2rayNG or NekoBox
    - **Windows:** v2rayN or NekoRay
    - **iOS:** V2Ray Tun, Streisand, or FoXray

*Important Note:* GitHub Codespaces is a temporary environment. It will automatically pause if you are inactive for about 30 minutes (i.e., if you close the browser tab). If your VPN stops working, simply go to `https://github.com/codespaces`, restart your Codespace, open the terminal, and run `bash run.sh` again. Always ensure the port is set to "Public".

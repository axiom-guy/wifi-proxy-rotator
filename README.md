# 🌐 Wi-Fi Proxy Rotator

A lightweight Bash utility to periodically rotate your system's wifi proxy.

## 🚀 Features

- Supports **HTTP**, **SOCKS4**, and **SOCKS5** proxies.
- Rotates proxy every _n_ seconds (default: 30 minutes).
- Optionally displays current IP to verify proxy effectiveness.
- Easy to customize.

## ⚙️ How It Works

- You choose the proxy type (HTTP, SOCKS4, or SOCKS5) at startup.
- The script picks a random proxy from the appropriate list in the `proxies/` folder.
- Sets `http_proxy` and `https_proxy` environment variables.
- (Optionally) displays your current IP using the proxy.
- Rotates to a new proxy after a fixed interval.

## 🛠️ Installation

```bash
git clone https://github.com/axiom-guy/wifi-proxy-rotator.git
cd wifi-proxy-rotator
chmod +x auto_proxy_rotate.sh
./auto_proxy_rotate.sh
```
## Note
You must create and populate the following files inside the proxies/ folder:<br>

proxies/http.txt — for HTTP proxies<br>
proxies/socks4.txt — for SOCKS4 proxies<br>
proxies/socks5.txt — for SOCKS5 proxies<br>

Each file should contain one proxy per line in format **ip:port**<br>

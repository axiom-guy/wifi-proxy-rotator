#!/bin/bash

# =============== CONFIG ===============
ROTATE_INTERVAL=1800  # 30 minutes
SHOW_IP=true          # Set to false to disable IP check
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
PROXY_DIR="$BASE_DIR/proxies"

# ============== FUNCTIONS ==============
function choose_proxy_type() {
    echo "🔧 Choose proxy type:"
    echo "1) HTTP"
    echo "2) SOCKS4"
    echo "3) SOCKS5"
    read -p "Enter choice [1-3]: " choice

    case "$choice" in
        1) PROTO="http" ;;
        2) PROTO="socks4" ;;
        3) PROTO="socks5" ;;
        *) echo "Invalid choice"; exit 1 ;;
    esac
}

function rotate_proxy_loop() {
    local file="$PROXY_DIR/${PROTO}.txt"
    local proxy_list
    proxy_list=()
    while IFS= read -r line; do
        proxy_list+=("$line")
    done < "$file"
    
    if [ "${#proxy_list[@]}" -eq 0 ]; then
        echo "No proxies found...!"
        exit 1
    fi

    echo "Starting proxy rotation every $ROTATE_INTERVAL seconds using ${PROTO} proxies..."
    while true; do
        PROXY=${proxy_list[$RANDOM % ${#proxy_list[@]}]}
        export http_proxy="$PROXY"
        export https_proxy="$PROXY"
        export all_proxy="$PROXY"
        
        echo "Proxy set to: $PROXY"

        if [ "$SHOW_IP" = true ]; then
            echo -n "IP: "
            curl -s --proxy "$PROXY" --max-time 10 ifconfig.me || echo "Proxy failed!"

        fi

        sleep "$ROTATE_INTERVAL"
    done
}

# ============== MAIN SCRIPT ==============
choose_proxy_type
rotate_proxy_loop


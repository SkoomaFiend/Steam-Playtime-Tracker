#!/bin/bash

# This Script waits for matching game process to open and calculates time played when it's closed

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <Game Name> <Process Name>"
    exit 1
fi

GAME_NAME="$1"
PROCESS_NAME="$2"



LOG_FILE="$HOME/.local/share/game-playtime/$GAME_NAME.log"

echo "Waiting for $PROCESS_NAME to start..."

# Wait until the game process appears
SELF_PID=$$

sleep 5

while [[ -z "$pid" ]]; do
    pid=$(pgrep -f "$PROCESS_NAME" | grep -v "$SELF_PID" | head -n1)
    sleep 1
done

echo "[$(date)] Detected $PROCESS_NAME with PID $pid"

start_time=$(date +%s)

# Wait until the process exits
while kill -0 "$pid" 2>/dev/null; do
    sleep 1
done
end_time=$(date +%s)
duration=$((end_time - start_time))
hours=$((duration / 3600))
minutes=$(((duration % 3600) / 60))
seconds=$((duration % 60))

echo "[$(date)] Ended $GAME_NAME. Duration: ${hours}h ${minutes}m ${seconds}s" >> "$LOG_FILE"
echo "Recorded $GAME_NAME playtime: ${hours}h ${minutes}m ${seconds}s"


#!/bin/bash

LOG_DIR="$HOME/.local/share/game-playtime"
OUTPUT_FILE="$LOG_DIR/summary.log"

if [[ ! -d "$LOG_DIR" ]]; then
    echo "No log directory found at $LOG_DIR"
    exit 1
fi

> "$OUTPUT_FILE"

grand_total_seconds=0

for log in "$LOG_DIR"/*.log; do
    [[ -e "$log" ]] || continue
    [[ "$(basename "$log")" == "summary.log" ]] && continue

    game_name=$(basename "$log" .log)

    total_seconds=0

    while IFS= read -r line; do
        if [[ $line =~ Duration:\ ([0-9]+)h\ ([0-9]+)m\ ([0-9]+)s ]]; then
            h=${BASH_REMATCH[1]}
            m=${BASH_REMATCH[2]}
            s=${BASH_REMATCH[3]}
            total_seconds=$((total_seconds + h * 3600 + m * 60 + s))
        fi
    done < "$log"

    hours=$((total_seconds / 3600))
    minutes=$(((total_seconds % 3600) / 60))
    seconds=$((total_seconds % 60))

    printf "%-30s %3dh %2dm %2ds\n" "$game_name" "$hours" "$minutes" "$seconds" >> "$OUTPUT_FILE"

    grand_total_seconds=$((grand_total_seconds + total_seconds))
done

# Compute grand total
g_hours=$((grand_total_seconds / 3600))
g_minutes=$(((grand_total_seconds % 3600) / 60))
g_seconds=$((grand_total_seconds % 60))

echo >> "$OUTPUT_FILE"
printf "%-30s %3dh %2dm %2ds\n" "TOTAL" "$g_hours" "$g_minutes" "$g_seconds" >> "$OUTPUT_FILE"

echo "Playtime summary written to: $OUTPUT_FILE"


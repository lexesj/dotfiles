#!/bin/bash

# Read JSON input
input=$(cat)

# Extract values
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

# Display model name
printf "%s" "$model"

# If we have context usage data, show progress bar and tokens
if [ -n "$used" ]; then
    # Convert to integer for calculation
    used_int=$(printf "%.0f" "$used")

    # Calculate bar segments (20 total width)
    filled=$((used_int / 5))
    empty=$((20 - filled))

    # Build progress bar
    bar="["
    for ((i = 0; i < filled; i++)); do bar+="█"; done
    for ((i = 0; i < empty; i++)); do bar+="░"; done
    bar+="]"

    # Calculate total tokens used
    total_tokens=$((total_input + total_output))

    # Format with K for thousands
    if [ $total_tokens -ge 1000 ]; then
        tokens_display=$(awk "BEGIN {printf \"%.1fK\", $total_tokens/1000}")
    else
        tokens_display="$total_tokens"
    fi

    # Display with percentage and token count
    printf " | Context: %s %d%% (%s/%dK tokens)" "$bar" "$used_int" "$tokens_display" "$((context_size / 1000))"
fi

printf "\n"

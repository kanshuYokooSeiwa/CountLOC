#!/bin/bash

# 1. CONFIGURATION
# ----------------
# Try to auto-detect git username. If blank, replace "kanshuYokoo" manually.
AUTHOR=$(git config user.name)
if [ -z "$AUTHOR" ]; then
  AUTHOR="kanshuYokoo" 
fi

# 2. INPUT VALIDATION
# -------------------
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: ./count_loc.sh <START_YEAR> <END_YEAR>"
  exit 1
fi

START_YEAR=$1
END_YEAR=$2

echo "Counting LOC (Gross Additions) for author: '$AUTHOR'"
printf "%-5s %-3s   %s\n" "YYYY" "MM" "LOC"

# 3. THE LOOP
# -----------
for year in $(seq "$START_YEAR" "$END_YEAR"); do
  for month in {01..12}; do
    
    # DATE LOGIC: Handle Dec -> Jan transition safely
    if (( 10#$month == 12 )); then
      next_m="01"
      next_y=$((year + 1))
    else
      next_m=$(printf "%02d" $((10#$month + 1)))
      next_y=$year
    fi

    SINCE="$year-$month-01"
    UNTIL="$next_y-$next_m-01"

    # MAIN LOGIC FIX:
    # awk '{ total += $1 }' -> Sums ONLY column 1 (Added lines)
    # We ignore column 2 (Deleted lines)
    LOC=$(git log --author="$AUTHOR" --since="$SINCE" --before="$UNTIL" --pretty=tformat: --numstat | \
      awk '{ total += $1 } END { print total }')

    # If git log returned nothing (empty string), treat as 0
    if [ -z "$LOC" ]; then LOC=0; fi

    printf "%-5s %-3s   %s\n" "$year" "$month" "$LOC"
    
  done
done

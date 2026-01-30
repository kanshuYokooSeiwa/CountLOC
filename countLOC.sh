#!/bin/bash

# 1. CONFIGURATION
# ----------------
# Change this to your Git username
AUTHOR="Your Name"

# 2. INPUT VALIDATION
# -------------------
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: ./count_loc.sh <START_YEAR> <END_YEAR>"
  echo "Example: ./count_loc.sh 2024 2025"
  exit 1
fi

START_YEAR=$1
END_YEAR=$2

echo "Counting LOC (Net Delta) for author: $AUTHOR"
echo "-------------------------------------------"
echo "YYYY MM   LOC"

# 3. THE LOOP
# -----------
# Loop through years
for year in $(seq "$START_YEAR" "$END_YEAR"); do
  
  # Loop through months 01 to 12
  for month in {01..12}; do
    
    # We use "31" for the end day as requested. 
    # Git is smart enough to handle months with fewer days (e.g. Feb) 
    # without crashing when passed an out-of-bounds date like "02-31".
    SINCE="$year-$month-01"
    UNTIL="$year-$month-31"

    # Run the git log command
    # We initialize awk vars to 0 to ensure we print "0" instead of blank for empty months
    LOC=$(git log --author="$AUTHOR" --since="$SINCE" --until="$UNTIL" --pretty=tformat: --numstat | \
      awk 'BEGIN { add=0; subs=0; loc=0 } \
           { add += $1; subs += $2; loc += $1 - $2 } \
           END { print loc }')

    # Formatting the output with printf to align columns
    # %-4s = Year (4 chars)
    # %-2s = Month (2 chars)
    # %s   = LOC count
    printf "%-4s %-2s   %s\n" "$year" "$month" "$LOC"
    
  done
done


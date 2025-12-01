#!/usr/bin/env bash
set -e

# Resolve directory of the script itself (repo root)
REPO_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$REPO_PATH"

# Ensure activity directory exists (keeps repo clean)
mkdir -p .activity

LOG_FILE=".activity/activity.log"

# Number of commits for the day (random 10–100)
COMMITS=$(( RANDOM % 91 + 10 ))

echo "Generating $COMMITS commits in $REPO_PATH..."

for ((i=1; i<=COMMITS; i++)); do
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Append a timestamped line
    echo "Commit $i at $TIMESTAMP" >> "$LOG_FILE"

    git add "$LOG_FILE"
    git commit -m "Automated commit $i at $TIMESTAMP"

    # Random sleep (5–60 seconds)
    SLEEP=$(( RANDOM % 56 + 5 ))
    sleep "$SLEEP"
done

git push
echo "Done!"

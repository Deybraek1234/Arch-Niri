#!/bin/bash

# Array of directories to backup
DIRECTORIES=("$HOME/stow/dotfiles" "$HOME/Appunti_Uni")
COMMIT_MESSAGE="Automated backup: $(date '+%Y-%m-%d %H:%M:%S')"
BRANCH="master" # Change to 'main' if needed

for dir in "${DIRECTORIES[@]}"; do
    if [ -d "$dir" ]; then
        echo "--- Backing up $dir ---"
        (
            cd "$dir" || exit
            git add . &&
            git commit -m "$COMMIT_MESSAGE" &&
            git push origin
        )
    else
        echo "Directory $dir not found, skipping."
    fi
done

echo "--- Backup process complete ---"

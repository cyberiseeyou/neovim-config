#!/usr/bin/env bash

# Define constants
DEPENDENCIES=("gcc" "make" "git" "ripgrep" "fd" "unzip" "neovim")
REPO_URL="https://github.com/cyberiseeyou/neovim-config.git"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BACKUP_DIR="$HOME/.config/nvim-old"

# Install dependencies
install_dependencies() {
    echo "Installing dependencies needed for Neovim..."
    for package in "${DEPENDENCIES[@]}"; do
        if ! pacman -Q "$package" > /dev/null 2>&1; then
            sudo pacman -S --noconfirm --needed "$package"
        fi
    done
}

# Backup the current Neovim configuration if it exists
backup_existing_config() {
    if [[ -d "$TARGET_DIR" ]]; then
        echo "Backing up existing Neovim configuration to $BACKUP_DIR..."
        mv -f "$TARGET_DIR" "$BACKUP_DIR"
    fi
}

# Clone the GitHub repository
clone_config() {
    echo "Cloning Neovim configuration repository..."
    if ! git clone "$REPO_URL" "$TARGET_DIR"; then
        echo "Error: Unable to clone repository."
        echo "Please check your network connection and repository URL."
        exit 1
    fi
}

# Main function to orchestrate steps
main() {
    install_dependencies
    backup_existing_config
    clone_config
    echo "Successfully installed Neovim configuration!"
    exit 0
}

# Execute the script
main


#!/usr/bin/env bash
set -e

detect_os() {
    case "$(uname -s)" in
        Linux*)     os="linux";;
        Darwin*)    os="macos";;
        CYGWIN*|MINGW*|MSYS*) os="windows";;
        *)          os="unknown";;
    esac
    echo "$os"
}

install_gh_linux() {
    if command -v apt >/dev/null 2>&1; then
        type -p curl >/dev/null || sudo apt install curl -y
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |
            sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |
            sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
        sudo apt update
        sudo apt install gh -y
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install 'dnf-command(config-manager)' -y
        sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo dnf install gh -y
    elif command -v yum >/dev/null 2>&1; then
        sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo yum install gh -y
    else
        echo "Unsupported Linux distribution for automatic installation."
        exit 1
    fi
}

install_gh_macos() {
    if command -v brew >/dev/null 2>&1; then
        brew install gh
    else
        echo "Homebrew not installed. Installing via pkg..."
        curl -fsSL https://github.com/cli/cli/releases/latest/download/gh_$(uname -m)_macOS.pkg -o gh.pkg
        sudo installer -pkg gh.pkg -target /
        rm gh.pkg
    fi
}

install_gh_windows() {
    echo "Windows detected. Use winget or choco:"
    echo "  winget install GitHub.cli"
    echo "  choco install gh"
}

main() {
    os=$(detect_os)
    echo "Detected OS: $os"

    case "$os" in
        linux) install_gh_linux;;
        macos) install_gh_macos;;
        windows) install_gh_windows;;
        *) echo "Unsupported OS"; exit 1;;
    esac
}

main

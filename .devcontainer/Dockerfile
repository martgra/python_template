ARG VARIANT=3.14-trixie
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

ARG USERNAME=vscode

# Install dependencies for lychee (link checker)
USER root
RUN apt-get update && apt-get install -y gcc pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

USER ${USERNAME}

# Install Rust and lychee link checker
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    . $HOME/.cargo/env && \
    cargo install lychee

RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mkdir -p /home/${USERNAME}/.cache && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.cache

RUN curl https://mise.run | sh && \
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> /home/${USERNAME}/.zshrc && \
    echo 'eval "$(~/.local/bin/mise activate bash)"' >> /home/${USERNAME}/.bashrc


# Ensure VS Code extension & history directories exist with correct ownership
RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
    && chown -R $USERNAME /home/$USERNAME/.vscode-server

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/home/$USERNAME/commandhistory/.zsh_history" \
    && mkdir -p /home/$USERNAME/commandhistory \
    && touch /home/$USERNAME/commandhistory/.zsh_history \
    && chown -R $USERNAME /home/$USERNAME/commandhistory \
    && grep -q "commandhistory/.zsh_history" /home/$USERNAME/.zshrc || echo "$SNIPPET" >> /home/$USERNAME/.zshrc

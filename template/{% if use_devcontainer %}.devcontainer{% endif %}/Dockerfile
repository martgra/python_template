ARG VARIANT=3.13-bookworm
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

ARG USERNAME=vscode
ARG UV_VERSION=v0.4.30

USER ${USERNAME}

RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mkdir -p /home/${USERNAME}/.cache && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.cache


# Ensure VS Code extension & history directories exist with correct ownership
RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
    && chown -R $USERNAME /home/$USERNAME/.vscode-server

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/home/$USERNAME/commandhistory/.zsh_history" \
    && mkdir -p /home/$USERNAME/commandhistory \
    && touch /home/$USERNAME/commandhistory/.zsh_history \
    && chown -R $USERNAME /home/$USERNAME/commandhistory \
    && grep -q "commandhistory/.zsh_history" /home/$USERNAME/.zshrc || echo "$SNIPPET" >> /home/$USERNAME/.zshrc

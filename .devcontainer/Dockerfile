ARG VARIANT=3-bookwork
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

ARG USERNAME=vscode

USER ${USERNAME}

RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mkdir -p /home/${USERNAME}/.cache && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.cache


RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
    && chown -R $USERNAME \
    /home/$USERNAME/.vscode-server

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/home/$USERNAME/commandhistory/.zsh_history" \
    && mkdir /home/$USERNAME/commandhistory \
    && touch /home/$USERNAME/commandhistory/.zsh_history \
    && chown -R $USERNAME /home/$USERNAME/commandhistory \
    && echo "$SNIPPET" >> "/home/$USERNAME/.zshrc"

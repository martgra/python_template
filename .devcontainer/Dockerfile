FROM mcr.microsoft.com/devcontainers/python:3.14-bookworm
ARG USERNAME=vscode

# Install dependencies for lychee (link checker)
USER root
RUN apt-get update && apt-get install -y gcc pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# Pre-create directories and set permissions
RUN mkdir -p /home/${USERNAME}/.cache \
    && mkdir -p /home/${USERNAME}/.local/share/mise \
    && mkdir -p /home/${USERNAME}/.vscode-server/extensions \
    && mkdir -p /home/${USERNAME}/commandhistory \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.cache \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.local \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.vscode-server \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/commandhistory

USER ${USERNAME}

# Install Rust and lychee link checker
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    . $HOME/.cargo/env && \
    cargo install lychee

ENV MISE_DATA_DIR=/home/${USERNAME}/.local/share/mise
ENV PATH=/home/${USERNAME}/.local/bin:${MISE_DATA_DIR}/shims:$PATH
RUN curl -fsSL https://mise.run | sh

RUN echo 'eval "$(mise activate zsh)"' >> /home/${USERNAME}/.zshrc \
    && echo 'eval "$(mise activate bash)"' >> /home/${USERNAME}/.bashrc \
    && echo 'export HISTFILE=/home/vscode/commandhistory/.zsh_history' >> /home/${USERNAME}/.zshrc \
    && echo 'export HISTSIZE=10000' >> /home/${USERNAME}/.zshrc \
    && echo 'export SAVEHIST=10000' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt SHARE_HISTORY' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_IGNORE_DUPS' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_IGNORE_ALL_DUPS' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_FIND_NO_DUPS' >> /home/${USERNAME}/.zshrc \
    && touch /home/${USERNAME}/commandhistory/.zsh_history

USER root

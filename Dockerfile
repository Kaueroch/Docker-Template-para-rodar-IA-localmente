FROM node:20-slim


# Instala ferramentas básicas usando o gerenciador do Debian (apt-get)
RUN apt-get update && \
    apt-get install -y --no-install-recommends git bash curl && \
    rm -rf /var/lib/apt/lists/*
# defini que o usuario com permissoes é o meu, ou seja, toda geracao de codigo ou algo irá vir pra mim.
ARG USERNAME=kauezao
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /workspace

RUN npm i -g opencode-ai


ENTRYPOINT ["opencode"]

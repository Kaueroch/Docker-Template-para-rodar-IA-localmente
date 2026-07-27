FROM node:20-slim

# Instala ferramentas básicas usando o gerenciador do Debian (apt-get)
RUN apt-get update && \
    apt-get install -y --no-install-recommends git bash curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN npm install -g freebuff

ENTRYPOINT ["freebuff"]

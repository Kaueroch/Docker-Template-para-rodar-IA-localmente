## Template Docker pra rodar IA locamente
O objetivo principal é conseguir testar e usar IAs de modelos novos que aparecem todos os dias de "graça", então não a IA acesso inteiro a sua máquina,entende? é esse o meu objetivo principal com isso.


## 🏗️ Estrutura do Projeto

O ambiente é configurado usando dois arquivos principais: `Dockerfile` e `docker-compose.yml`. Abaixo está a documentação de como cada parte funciona.

### 📄 Dockerfile

O `Dockerfile` é a receita de como a imagem do nosso container será construída.

- `FROM node:20-slim`: Define a imagem base. O Docker vai buscar essa versão enxuta (slim) do Node.js (versão 20) no Docker Hub para ser a fundação do nosso container.
- `RUN apt-get update && apt-get install ...`: Quando o container é construído a partir da imagem do Node, este comando roda no terminal do Debian (sistema base) para instalar ferramentas essenciais que a IA pode precisar, como `git`, `bash` e `curl`.
- `WORKDIR /workspace`: Cria uma área de trabalho virtual (um diretório) dentro do container. É onde os comandos serão executados por padrão. E que pode ser alterado para onde voce deseje que seja rodado.
- `RUN npm install -g NOME-DA-IA`: Usa o gerenciador de pacotes do Node (`npm`) para instalar a IA de sua preferencia globalmente dentro do container.
- `ENTRYPOINT ["freebuff"]`: É o ponto de entrada principal. Assim que o container iniciar, ele executará automaticamente o Freebuff (abrindo a sua tela de login/interface).

### 🐙 Docker Compose

O arquivo `docker-compose.yml` orquestra como o container vai rodar, facilitando a execução.

- `services`: Define os serviços que vão rodar quando executarmos o comando `docker compose up` ou `docker compose run`.
- `freebuff`: É o nome do nosso serviço.
    - `build.context: .`: Diz ao Docker para construir a imagem usando o diretório atual (`.`) como base.
    - `dockerfile: Dockerfile`: Aponta qual arquivo usar para a construção.
    - `container_name: freebuff_cli`: Atribui um nome fixo e amigável ao container, em vez de um nome aleatório gerado pelo Docker.
    - `stdin_open: true` e `tty: true`: Mantêm o terminal interativo aberto. Isso é **essencial** para que ferramentas de CLI (linha de comando) como o Freebuff funcionem e aceitem nossos comandos.
    - `volumes`: Mapeia dados entre a máquina local (host) e o container.
        - `- /home/exemplo/projeto:/workspace`: Conecta a pasta raiz `/home/kauezao` da máquina ao diretório `/workspace` do container. *(Nota: como o meu objetivo é não expor todo o SO, no futuro você pode mapear apenas a pasta do projeto específico em vez da sua home inteira, aumentando a segurança).*
    - `working_dir: /workspace`: Define que, ao iniciar, o container deve se posicionar nesta pasta.

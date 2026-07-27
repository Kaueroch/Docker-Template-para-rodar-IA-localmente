# 🐳 Sandbox Docker para Testes de IA (Freebuff CLI)

Este projeto nasceu da vontade de aprender mais sobre o **Docker** e da necessidade de testar diferentes modelos e ferramentas de Inteligência Artificial (como o `freebuff`) de forma mais segura. 

O objetivo principal é conseguir experimentar várias IAs no dia a dia, buscando alternativas eficientes e econômicas (para evitar assinaturas caras), **sem precisar dar acesso direto a todo o meu sistema operacional** para essas ferramentas. Através deste template de Docker,criamos um container onde a IA executa de forma local e protege a maquina do host.

---

## 🏗️ Estrutura do Projeto

O ambiente é configurado usando dois arquivos principais: `Dockerfile` e `docker-compose.yml`. Abaixo está a documentação de como cada parte funciona.

### 📄 Dockerfile

O `Dockerfile` é a receita de como a imagem do nosso container será construída.

- `FROM node:20-slim`: Define a imagem base. O Docker vai buscar essa versão enxuta (slim) do Node.js (versão 20) no Docker Hub para ser a fundação do nosso container.
- `RUN apt-get update && apt-get install ...`: Quando o container é construído a partir da imagem do Node, este comando roda no terminal do Debian (sistema base) para instalar ferramentas essenciais que a IA pode precisar, como `git`, `bash` e `curl`.
- `WORKDIR /workspace`: Cria uma área de trabalho virtual (um diretório) dentro do container. É onde os comandos serão executados por padrão.
- `RUN npm install -g freebuff`: Usa o gerenciador de pacotes do Node (`npm`) para instalar o `freebuff` globalmente dentro do container.
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
        - `- /home/kauezao:/workspace`: Conecta a pasta raiz `/home/kauezao` da máquina ao diretório `/workspace` do container. *(Nota: como o seu objetivo é não expor todo o SO, no futuro você pode mapear apenas a pasta do projeto específico em vez da sua home inteira, aumentando a segurança).*
    - `working_dir: /workspace`: Define que, ao iniciar, o container deve se posicionar nesta pasta.

---

## 🚀 Próximos Passos (Futuro)

- **Testar Novos Modelos:** A ideia é usar essa base para testar outros modelos e IAs no dia a dia.
- **Encontrar a Ferramenta Ideal:** Buscar uma IA que seja excelente para o uso rotineiro, ajudando a evitar ou reduzir os custos com assinaturas, explorando o limite do que a tecnologia pode oferecer de forma acessível.
- **Refinar o Isolamento:** Ajustar os volumes mapeados para garantir que as IAs tenham acesso estritamente ao que for necessário para determinada tarefa, sem expor dados pessoais do host.

---


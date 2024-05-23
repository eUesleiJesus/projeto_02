# projeto_02
 Configuração de Ambiente de Desenvolvimento com Docker e Express.js

Este script automatiza a configuração de um ambiente de desenvolvimento Node.js com Docker. 

# Fase 1: Instalação do Docker

1. Verificação de Privilégios de Root:
   O script verifica se está sendo executado com privilégios de root usando $EUID. Se não for root, ele exibe uma mensagem e sai.
   
2. Atualização do Sistema:
  O script atualiza o índice de pacotes do sistema usando apt-get update.

3. Instalação de Dependências:
  Instala os pacotes necessários para o Docker usando apt-get install:
    apt-transport-https: Permite o download de pacotes por HTTPS.
    ca-certificates: Fornece certificados confiáveis.
    curl: Usado para baixar arquivos da internet.
    gnupg2: Ferramenta para verificação de assinatura digital.
    software-properties-common: Ferramentas para gerenciar software.
    lsb-release: Fornece informações sobre a versão do Linux.

4. Adição da Chave GPG do Docker:
   Baixa e adiciona a chave GPG do repositório do Docker usando curl e gpg.

5. Adição do Repositório do Docker:
   Adiciona o repositório estável do Docker ao sistema usando tee.

6. Atualização do Sistema (Novamente):

7. Instalação do Docker:
 Instala o Docker Engine, CLI e containerd
   docker-ce: Docker Engine (comunidade).
   docker-ce-cli: Docker CLI (interface de linha de comando).
   containerd.io: Runtime de contêiner.
   
8. Instalação do Docker Compose:
   Instala o Docker Compose, uma ferramenta para definir e gerenciar aplicativos multi-contêiner
   
9. Adição do Usuário ao Grupo Docker:
  Adiciona o usuário atual ao grupo docker usando usermod para permitir a execução de comandos do Docker sem sudo.

10. Verificação da Instalação:
   Exibe as versões do Docker e Docker Compose usando docker --version e docker-compose --version.

11. Inicialização Automática do Docker:
   Habilita o serviço do Docker para iniciar automaticamente na inicialização do sistema usando systemctl enable docker.

12.Reinicialização do Serviço Docker:
    Reinicia o serviço do Docker para aplicar as alterações usando systemctl restart docker.

# Fase 2: Criação de um Aplicativo Express

13. Criação de Diretório:
  Cria um diretório para o projeto usando mkdir.
14. Acesso ao Diretório:
  Navega até o diretório do projeto usando cd.
15. Criação do package.json:
  Cria um arquivo package.json usando cat << EOF > package.json, que define as dependências e scripts do projeto.
16. Criação do index.js:
   Cria um arquivo index.js usando cat << EOF > index.js, que contém um aplicativo Express simples.
Criação do Dockerfile:
17. Cria um Dockerfile usando cat > Dockerfile <<EOF, que define como construir a imagem do Docker para o aplicativo:
  Define a imagem base como node:18-alpine.
  Define o comando para iniciar o app como npm start.

18. Construção da Imagem do Docker:
   Constrói a imagem do Docker usando o Dockerfile criado com docker build.

# Fase 3 & 4: Inicialização e Verificação do Aplicativo

19. Inicialização do Contêiner:
 Inicia um contêiner Docker da imagem construída usando docker run, mapeando a porta do contêiner para a porta do host.

20. Verificação do Aplicativo:
  Verifica se o aplicativo está em execução acessando http://localhost:${APP_PORT} usando curl.

# Fase 5: Mensagem de Sucesso:
Exibe uma mensagem de sucesso com instruções para acessar o aplicativo.

# Execução do Scriptp:
## Chamadas de Função:
## Executa as funções definidas anteriormente em ordem:
1. instalar_docker()
2. criar_app_express()
3. iniciar_app()
4. verificar_app()
5. mostrar_mensagem_sucesso()
   
Este script automatiza o processo de configuração de um ambiente de desenvolvimento Node.js com Docker, desde a instalação do Docker até a execução do aplicativo.

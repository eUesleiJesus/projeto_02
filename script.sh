#!/bin/bash

# esté é um script de instalação de docker e docker-compose

# configurações iniciais
APP_NAME="tapioca-app"
APP_DIR="tapioca-app"
APP_PORT=3000

# função para instalar o Docker
instalar_docker(){

# 1. Verificação de permissão de root
if [ "$EUID" -ne 0 ]
  then echo "Por favor, execute como root"
  exit
fi

# 2. Atualização do sistema
apt-get update

# 3. Instalação de dependências
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common lsb-release

# 4. Adição da chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 5. Adição do repositório oficial do Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 6. Atualização do sistema
apt-get update

# 7. Instalação do Docker
apt-get install -y docker-ce docker-ce-cli containerd.io

# 8. Instalação do Docker Compose
apt-get install -y docker-compose

# 9. Adição do usuário ao grupo do Docker
usermod -aG docker $USER

# 10. Verificação da instalação
docker --version
docker-compose --version

# 11. Iniciar automaticamente no boot
systemctl enable docker

# 12. Reiniciar o serviço
systemctl restart docker
    
    }

# função para criar um app Express
criar_app_express() {
# 13. criar um diretório para o projeto
mkdir -p "$APP_DIR"

# 14. entrar no diretório
cd "$APP_DIR"

# 15. criar arquivo package.json
cat << EOF > package.json
{
  "name": "$APP_NAME",
  "version": "1.0.0",
  "description": "aplicação Express",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOF

# 16. criar arquivo index.js
cat << EOF > package.json
{
  "name": "Express",
  "version": "1.0.0",
  "description": "aplicação Express",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOF

cat << EOF > index.js
const express = require('express');
const app = express();
const port = ${APP_PORT};

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.log(\`Servidor rodando em http://localhost:\${port}\`);
});
EOF

# 17. criar arquivo Dockerfile
cat > Dockerfile <<EOF
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./


RUN npm install -g nodemon express-generator

RUN express --view=pug --force "$APP_NAME"

WORKDIR /app/ "$APP_NAME"

COPY package*.json ./

RUN npm install


COPY . .

EXPOSE ${APP_PORT}

CMD ["npm", "start"]
EOF

#18 construir a imagem do Docker
docker build -t "$APP_NAME" .

}

# função para iniciar a aplicação
iniciar_app() {
#19 rodar a imagem do Docker
docker run -p "${APP_PORT}":"${APP_PORT}" -d "$APP_NAME"
}

# função para verificar se a aplicação está rodando
verificar_app() {
#20 verificar se a aplicação está rodando
curl http://localhost:${APP_PORT}
}

# função para mostrar mensagem de sucesso
mostrar_mensagem_sucesso() {
#21. Mensagem de sucesso
echo "Ambiente de desenvolvimento configurado com sucesso!!!!"
echo " Acesse http://localhost:3000 para visualizar a aplicação."
echo "Bem-vindo ao "$APP_NAME"."


}

#22. Execução do script

instalar_docker
criar_app_express
iniciar_app
verificar_app
mostrar_mensagem_sucesso
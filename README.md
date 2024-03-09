# Sonarqube com NGINX

O projeto consiste na configuração do Sonarqube utilizando o NGINX como proxy reverso em um ambiente linux. Eles vão ser provisionados em um container e por isso foi criado um docker compose para realizar a subida dos mesmos.

## Instalação

* **Obs: Os scripts .sh foram testados em somente no SO Ubuntu - 20.04**

1. Primeiramente é necessário ter o docker instalado em seu ambiente.
   - Ubuntu: Para isso foi criado um script bash para realizar a instalação do mesmo bastando apenas executá-lo para instalar o docker
     - `./install_docker.sh`

   - Para outros SO's consultar o manual do docker
     - https://docs.docker.com/engine/install/

2. Após instalar o docker, será necessário realizar algumas configurações para o Sonarqube e então executar o docker compose.
   - Ubuntu: Visando facilitar o processo, foi criado um script para realizar essa configuração.
     - `./setup.sh`
    
   - **Configuração Manual**
     - Alterar vm.max_map_count e fs.file-max
       ```
       sudo sysctl -w vm.max_map_count=524288
       sudo sysctl -w fs.file-max=131072
       ulimit -n 131072
       ulimit -u 8192
       ```

     - Volume parametrizado no docker compose

       **Obs: O volume pode ser modificado de acordo com a preferência do usuário.**

       - No docker compose existe um volume configurado na pasta "/nginx/conf", onde deve ser colocado o conteúdo da pasta "nginx/conf" presente no repositório.
       - Isso pode ser feito acessando a pasta raiz do repositório e executando o seguinte comando.
         ```
         sudo mkdir -p /nginx/conf/
         sudo cp -r ./nginx/conf/* /nginx/conf/
         ```

      - Subir docker compose
        - Para subir o docker compose basta executar o seguinte comando na pasta raiz do repositório
          `docker compose up -d`
          
3. Acessar o Sonarqube
   - No arquivo de configurações do NGINX (/sonar/conf/nginx_default.conf) ele redireciona os acessos do DNS http://sonar para o Sonarqube.
   - Entao é necessário configurar o DNS, e modificar a configuração de acordo com sua necessidade.
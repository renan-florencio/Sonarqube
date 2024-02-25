#!/bin/bash
#!/bin/expect

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; 
do 
    sudo apt-get remove $pkg; 
done

sudo apt-get update -y 
sudo apt-get install -y ca-certificates curl grep
sudo install -m 0755 -d /etc/apt/keyrings 
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y 

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker ${USER}

sudo service docker start
sudo service docker status | grep -E "docker.service - |TriggeredBy|Active"

echo -e "\nSerá necessário realizar o novamente o login na máquina!"
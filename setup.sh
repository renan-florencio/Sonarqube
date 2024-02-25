sudo sysctl -w vm.max_map_count=524288
sudo sysctl -w fs.file-max=131072
ulimit -n 131072
ulimit -u 8192

NGINX="/nginx/conf/"
if [ ! -d "$NGINX" ]; then
    sudo mkdir -p $NGINX
fi

sudo cp -r ./nginx/conf/* $NGINX

$(docker compose up -d)
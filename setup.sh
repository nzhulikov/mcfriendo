#!/bin/bash
set -e

# 1. Установка Rust
if ! command -v rustc &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
fi

# 2. Установка PostgreSQL
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# 3. Установка nginx и certbot
sudo apt install -y nginx
sudo apt install -y certbot python3-certbot-nginx

# 4. Создание systemd unit-файла
sudo tee /etc/systemd/system/mcfriendo.service > /dev/null <<EOL
[Unit]
Description=McFriendo Telegram Bot
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$HOME/mcfriendo
ExecStart=$HOME/mcfriendo/mcfriendo
EnvironmentFile=$HOME/mcfriendo/.env
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

# 5. Переменные окружения
if [ ! -f "$HOME/mcfriendo/.env" ]; then
  echo "Создайте .env файл в $HOME/mcfriendo/.env и заполните переменные."
fi

# 6. Перезапуск сервисов
sudo systemctl daemon-reload
sudo systemctl enable mcfriendo.service
sudo systemctl restart mcfriendo.service

echo "McFriendo setup complete!" 
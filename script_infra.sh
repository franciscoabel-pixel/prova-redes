#!/bin/bash
# ==============================================
# Script: setup_infra.sh
# Autor: Francisco Abel
# Data: 14/08/2025
# Objetivo: Configuração automática do servidor TechLog no Debian 13
# ==============================================

# 1. Criação de grupos
echo "📌 Criando grupos..."
groupadd desenvolvedores
groupadd operacoes

# 2. Criação de usuários
echo "📌 Criando usuários..."
for user in dev1 dev2; do
    useradd -m -s /bin/bash -G desenvolvedores $user
    echo "$user:1234" | chpasswd
done

for user in ops1 ops2; do
    useradd -m -s /bin/bash -G operacoes $user
    echo "$user:1234" | chpasswd
done

useradd -m -s /bin/bash -G desenvolvedores,operacoes techlead
echo "techlead:1234" | chpasswd

# 3. Estrutura de diretórios e permissões
echo "📌 Criando diretórios e configurando permissões..."
mkdir -p /srv/app
chown :desenvolvedores /srv/app
chmod 770 /srv/app
setfacl -m g:operacoes:rx /srv/app

# 4. Instalação de pacotes
echo "📌 Atualizando sistema e instalando pacotes..."
apt update && apt upgrade -y
apt install apache2 quota ufw acl -y

# 5. Página HTML e configuração do Apache
echo "📌 Criando página HTML e configurando Apache..."
echo "<h1>Bem-vindo à TechLog!</h1>" > /srv/app/index.html
sed -i 's|DocumentRoot .*|DocumentRoot /srv/app|' /etc/apache2/sites-enabled/000-default.conf
chown -R www-data:desenvolvedores /srv/app
chmod -R 775 /srv/app
systemctl restart apache2

# 6. Configuração de cotas de disco no "/"
echo "📌 Configurando cotas de disco no / ..."
if ! grep -q "usrquota" /etc/fstab; then
    sed -i '/\/[[:space:]]/ s/defaults/defaults,usrquota,grpquota/' /etc/fstab
    mount -o remount /
    quotacheck -cug /
    quotaon /
fi

for user in dev1 dev2 ops1 ops2 techlead; do
    setquota -u $user 200000 250000 0 0 /
done

# 7. Firewall
echo "📌 Configurando firewall UFW..."
ufw allow 22
ufw allow 80
ufw --force enable

# 8. Exibir PID e status do Apache
echo "📌 Verificando PID e status do Apache..."
pidof apache2
systemctl status apache2 --no-pager

echo "✅ Configuração concluída!"

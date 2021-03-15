sudo apt install net-tools
sudo apt update
sudo apt install -y apache2 apache2-utils
sudo systemctl enable apache2
sudo apt install mariadb-server mariadb-client
sudo systemctl enable mariadb
sudo apt install php libapache2-mod-php php-mysql -y
sudo apt install clamav clamav-daemon -y
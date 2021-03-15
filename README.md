# ubuntu-hardening
NP CSF SCS ☁️ Module Individual Assignment

## Installation and Dependencies
* [Ubuntu Server 20.04.1+ (20.04 LTS)](https://ubuntu.com/download/server), select Option 2. Can also choose to deploy on the Cloud--GCP, Linode etc.
* [req.sh](https://github.com/RyanNgCT/ubuntu-hardening/blob/main/dependencies/req.sh) (contains all pre-requisite packages and/or dependencies): **WARNING** this was not tested by the author and is a minimal and quick way to set up your environment, configuration is still required.
* [Slides for server hardening](https://docs.google.com/presentation/d/1L1b1AIIjt6Fb_5auAaVlQ-g5eTmZ9nfo9hBRdok8h78/edit?usp=sharing).
* GUI is optional and Ubuntu 18.04+ Client VM would be helpful to test `ssh` hardening.

## Secure Checklist
- [x] [LAMP Stack](https://www.linuxbabe.com/ubuntu/install-lamp-stack-ubuntu-20-04-server-desktop)

**Part 1. Apache 2.x**

Step 1: Install Apache2 Package and make boot-persistent
```
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install -y apache2 apache2-utils
$ sudo systemctl enable apache2                          # run on startup
```
Test 1: If Apache is running: If it shows no error message, press `q` to quit and move on to the next steps.

```
$ sudo systemctl status apache2
```

Step 2: Miscellanous steps to start service
```
$ sudo ufw allow http
$ sudo chown www-data:www-data /var/www/html/ -R          # good idea to change to www-data instead of root
$ sudo systemctl reload apache2
```
Test 2: now you can try to access the web server by going to http://xxx.xxx.xxx.xxx which is your ip address (run `ifconfig`) or using `localhost` or `127.0.0.1` (loopback).

![apache2](https://github.com/RyanNgCT/ubuntu-hardening/blob/main/images/apache2.png)


**Part 2. MariaDB and MySQL Secure Installation**

Step 1: Install MariaDB
```
$ sudo apt install mariadb-server mariadb-client
$ sudo systemctl enable mariadb                          # run on startup
```
Test 1: If MariaDB is running: If it shows no error message, press `q` to quit and move on to the next steps.
```
$ sudo systemctl status mariadb                          
```

Step 2: MySQL Secure Installation
```
$ sudo mysql_secure_installation
```
Press `Y` or `y` for all other options at prompt, key in a decent alphanumeric password (select `1` when prompted for medium-strength password).

Test 2: Verify MariaDB Installation
```
$ sudo mariadb -u root
...
[mariadb] > exit
$ 
```
**3. PHP 7.x**

Step 1: PHP package installation
```
$ sudo apt install php libapache2-mod-php php-mysql -y      # requires additional config I will not cover
```
OR
```
$ sudo apt install php7.4 libapache2-mod-php7.4 php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline
$ sudo a2enmod php7.4
$ sudo systemctl restart apache2
```
Test 1: Navigate to http://xxx.xxx.xxx.xxx/info.php which is your ip address or localhost/info.php and you should see a page like below:

![php](https://github.com/RyanNgCT/ubuntu-hardening/blob/main/images/php.png)
```
$ sudo nano /var/www/html/info.php

# in the nano editor, enter the following and save
<?php phpinfo(); ?>
```

Step 2: Remove default PHP and index.html pages
```
# make a html file called index.html somewhere
$ sudo mv /<path>/<to>/<file>.index.html /var/www/html/index.html
$ sudo rm /var/www/html/info.php
```
Test 2: You should no longer be able to see the default pages when you try to navigate to them.

Installing Phpmyadmin is optional. See [here](https://www.linuxbabe.com/ubuntu/install-phpmyadmin-apache-lamp-ubuntu-20-04) for more.

---

- [x] SSH Keys for Authentication
```
$ ssh-keygen -t rsa 4096 -C “ubuntu client”
$ scp -p <port> <path> id@<ipaddr>:~/.ssh/authorized_keys
```

---

- [x] Antimalware: ClamAV

**Part 1. Installing ClamAV**
```
$ sudo apt install clamav clamav-daemon -y
$ sudo systemctl stop clamav-freshclam
$ sudo systemctl start clamav-daemon.service
$ sudo freshclam                                                    #update AV defs
$ sudo systemctl start clamav-freshclam.service
```

**Part 2. Install and Configure ClamTK (ClamAV GUI)**
```
$ sudo apt install clamtk -y
```
Configure according to own preference using GUI.

---

- [x] Linux Firewall (ufw)
```
$ sudo ufw default deny incoming
$ sudo ufw default allow outgoing
$ sudo ufw allow <port>/tcp                           # make sure correct port
$ sudo ufw allow http
$ sudo ufw allow https
$ sudo ufw enable
```
In this exercise, I changed the `ssh` port to `727` from `22` (see the slides). Since it is a web server, we will allow `http`/`https` traffic for both incoming and outgoing connections.

## Miscellaneous 
- [x] Ubuntu Desktop (and Screen Manager)

Mainly following [this guide](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04#step-4-%E2%80%94-setting-up-virtual-hosts-(recommended))
```
$ sudo apt install net-tools                                      # for ifconfig
$ sudo apt install tasksel

# SELECT "UBUNTU-DESKTOP" using [SPACEBAR], leave defaults, press [TAB] and then [ENTER] on "OK" to confirm.
# wait for installation to complete

$ sudo reboot                                                    # login using credentials

```
- [x] Troubleshooting Server 20.04 Clipboard Issues

There was some problem with the clipboard during my installation of lamp stack when I wanted to copy commands. I used these articles to troubleshoot, finally I managed to fix the issue with these 2 commands
* [Copy/paste and drag & drop not working in VMware machine with Ubuntu](https://askubuntu.com/questions/691585/copy-paste-and-dragdrop-not-working-in-vmware-machine-with-ubuntu) 
* [Copy/paste not working in VMware](https://askubuntu.com/questions/985924/copy-paste-not-working-in-vmware/994361)

```
$ sudo apt-get install open-vm-tools-desktop
$ sudo reboot
```
---

Edit the corresponding files as per the slides above to further harden the server. 

Here are the files that are unique to my setup.
* [Apache2 Config File](https://github.com/RyanNgCT/ubuntu-hardening/blob/main/dependencies/apache2.conf) (may have to rid the `^M`)
* [index.html](https://github.com/RyanNgCT/ubuntu-hardening/blob/main/dependencies/index.html)
* [dev.html](https://github.com/RyanNgCT/ubuntu-hardening/blob/main/dependencies/dev.html)




## References
* GUI: https://www.youtube.com/watch?v=mz3EFqNpLbQ
* Securing the Server (General):
   * https://christitus.com/secure-web-server/
   * https://techguides.yt/guides/secure-linux-server/
* Securing LAMP
   * [Hackersploit playlist](https://www.youtube.com/watch?v=Ryu3SDPYNb8&list=PLBf0hzazHTGMG7fJvZoAAw-JE3WyMIOQv)
* ClamAV
   * https://www.addictedtotech.net/how-to-install-clamav-on-ubuntu-20-4-lts-linux/





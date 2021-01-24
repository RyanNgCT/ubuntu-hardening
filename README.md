# ubuntu-hardening
NP CSF SCS ☁️ Module Individual Assignment

## Installation and Dependencies
* Ubuntu Server 20.04.1 (20.04 LTS)
* requirements.txt (contains all pre-requisite packages and/or dependencies)--Work In Progress 🚧

## Secure Checklist
- [ ] User / Account Management
- [ ] SSH Keys for Authentication
- [ ] Disk Encryption for Linux
- [ ] Linux Firewall

## Miscellaneous 
- [x] Ubuntu Desktop (and Screen Manager)

Mainly following [this guide](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04#step-4-%E2%80%94-setting-up-virtual-hosts-(recommended))
```
$ sudo apt install net-tools                                      # for ifconfig
$ sudo apt install tasksel

# SELECT "UBUNTU-DESKTOP" using [SPACEBAR], leave defaults, press [TAB] and then [ENTER] on "OK" to confirm.
# wait for installation to complete

$ sudo reboot                                             # login using credentials

```
- [x] Troubleshooting Server 20.04 Clipboard Issues

There was some problem with the clipboard during my installation of lamp stack when I wanted to copy commands. I used these articles to troubleshoot, finally I managed to fix the issue with these 2 commands
* [Copy/paste and drag & drop not working in VMware machine with Ubuntu](https://askubuntu.com/questions/691585/copy-paste-and-dragdrop-not-working-in-vmware-machine-with-ubuntu) 
* [Copy/paste not working in VMware](https://askubuntu.com/questions/985924/copy-paste-not-working-in-vmware/994361)

```
$ sudo apt-get install open-vm-tools-desktop
$ sudo reboot
```


- [ ] LAMP/XAMPP Stack installation 🚧

1. Apache 2
```
$ sudo apt update
$ sudo apt install apache2 -y
$ sudo ufw app info "Apache Full"
$ sudo ufw allow in "Apache Full"
```
Testing: now you can try to access the web server by going to http://xxx.xxx.xxx.xxx which is your ip address (run `ifconfig`) or using `localhost` or `127.0.0.1` (loopback).


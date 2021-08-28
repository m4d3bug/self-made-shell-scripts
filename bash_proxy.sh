#!/bin/bash 
# Descriptions: Use for setup proxy quickly
# Usage: mv bash_proxy.sh /etc/profile.d && source /etc/profile.d/bash_proxy.sh
function proxy_off() {
     unset HTTP_PROXY
     unset HTTPS_PROXY
     unset FTP_PROXY
     unset SOCKS5_PORXY
     unset http_proxy
     unset https_proxy
     unset ftp_proxy
     unset socks5_proxy
     echo -e "已关闭代理"
}

function proxy_on() {
     export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
     export MY_PROXY_URL="http://xxx.xxx.xxx.xxx:1081"
     export HTTP_PROXY=$MY_PROXY_URL
     export HTTPS_PROXY=$MY_PROXY_URL
     export FTP_PROXY=$MY_PROXY_URL
     export SOCKS5_PORXY=$MY_PROXY_URL
     export http_proxy=$MY_PROXY_URL
     export https_proxy=$MY_PROXY_URL
     export ftp_proxy=$MY_PROXY_URL
     export socks5_proxy=$MY_PROXY_URL
     echo -e "已开启代理"
}

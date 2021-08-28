#!/bin/bash
# Description: Strip Out Unique Data
# Usage: sudo chmod +x ubuntu1804-strip-out-unique.sh && sudo ./ubuntu1804-strip-out-unique.sh
function upgrade_to_latest_on (){
  echo -e "===>Upgrading to the latest<==="
  apt update && apt upgrade -y && apt clean
}

function stop_log_service_on (){
  echo -e "===>  Stopping log service <==="
  systemctl stop rsyslog
}

function clean_log_on (){
  echo -e "===>   Cleaning log file   <==="
  truncate -s0 /var/log/*tmp
  truncate -s0 /var/log/*log
  truncate -s0 /var/log/*/*log
}

function clean_tmp_on (){
  echo -e "===>Cleaning temp directory<==="
  rm -rf /tmp/*
  rm -rf /var/tmp/*
}

function clean_ssh_on (){
  echo -e "===>    Cleaning ssh key   <==="
  rm -f /etc/ssh/ssh_host_*
  echo -e "===>Adding refresh ssh key <==="
  echo 'test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server &> /dev/null && rm -rf /tmp/refresh_ssh.sh' > /tmp/refresh_ssh.sh 
  chmod +x /tmp/refresh_ssh.sh
  cat > /etc/systemd/system/refresh_ssh.service << EOF
[Unit]
Description=Run a Custom Script at Startup
After=default.target

[Service]
ExecStart=/tmp/refresh_ssh.sh && rm -rf /etc/systemd/system/refresh_ssh.service

[Install]
WantedBy=default.target
EOF
}

function clean_bash_history_on(){
  echo -e "===> Cleaning bash history <==="
  cat /dev/null > ~/.bash_history && history -c
  history -w
}

function ready_to_reboot_on(){
  echo -e "===>    Going to reboot    <==="
  rm -rf /var/log/journal/*
  rm -f $PWD/ubuntu1804-strip-out-unique.sh
  systemctl daemon-reload
  systemctl enable refresh_ssh.service
  shutdown -h now
}

upgrade_to_latest_on
stop_log_service_on
clean_log_on
clean_tmp_on
clean_ssh_on
clean_bash_history_on
ready_to_reboot_on

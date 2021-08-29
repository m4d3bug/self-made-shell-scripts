# Description: Strip Out Unique Data
# Usage: sudo chmod +x centos7-strip-out-unique.sh && sudo ./centos7-strip-out-unique.sh
function upgrade_to_latest_on (){
  echo -e "===>Upgrading to the latest<==="
  yum makecache fast && yum makecache && yum repolist && yum update -y && yum clean all && rm -rf /var/cache/yum
}

function stop_log_service_on (){
  echo -e "===>  Stopping log service <==="
  systemctl stop rsyslog
}

function clean_log_on (){
  echo -e "===>   Cleaning log file   <==="
  truncate -s0 /var/log/*/* &> /dev/null
  truncate -s0 /var/log/* &> /dev/null
}

function clean_tmp_on (){
  echo -e "===>Cleaning temp directory<==="
  rm -rf /tmp/*
  rm -rf /var/tmp/*
}

function clean_ssh_on (){
  echo -e "===>    Cleaning ssh key   <==="
  rm -f /etc/ssh/ssh_host_*
}

function clean_bash_history_on(){
  echo -e "===> Cleaning bash history <==="
  cat /dev/null > ~/.bash_history && history -c
  history -w
}

function ready_to_reboot_on(){
  echo -e "===>    Going to shutdown  <==="
  rm -rf /var/log/journal/*
  rm -f $PWD/centos7-strip-out-unique.sh
  sys-unconfig
}

upgrade_to_latest_on
stop_log_service_on
clean_log_on
clean_tmp_on
clean_ssh_on
clean_bash_history_on
ready_to_reboot_on

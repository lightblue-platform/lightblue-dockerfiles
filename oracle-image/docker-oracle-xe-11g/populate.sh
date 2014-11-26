#!/bin/bash
touch /STARTED
i=1
while [ "$i" -ne 0 ]
do
  echo "A new try"
  unset -f NREADY
  unset -v NREADY
  unset NREADY
  NREADY=$( /etc/init.d/oracle-xe status | fgrep '"XE", status READY' | wc -l)
  echo "NREADY $NREADY"
  if [ $NREADY -eq 2 ]; then
    touch /READY
    unset -f NLIS
    unset -v NLIS
    unset NLIS
    NLIS=$( /u01/app/oracle/product/11.2.0/xe/bin/tnsping localhost | grep 'OK ' | wc -l)
    echo "NLIS $NLIS"
    if [ $NLIS -eq 1  ]; then  
      echo "Listener and TNS are working";
      touch /NLIS
      sqlplus system/oracle@localhost @data.sql
      i=0
    fi
  fi
  sleep 10
done


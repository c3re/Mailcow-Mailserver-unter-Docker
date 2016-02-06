for var in mysql apache2 fail2ban rsyslog ${httpd_platform} ${fpm} spamassassin fuglu dovecot postfix opendkim clamav-daemon
    do
        service $var stop
        sleep 5
        service $var start
    done
fuglu


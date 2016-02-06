
apt-get -y update
apt-get -y upgrade
apt-get -y purge exim4* nginx* apache2*

# nano mailcow.config
# nano includes/functions.sh

./install.sh


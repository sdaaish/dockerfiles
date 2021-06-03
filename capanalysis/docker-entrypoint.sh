#!/usr/bin/env bash

# Setup correct policys
printf '#!/bin/sh\n' > /usr/sbin/policy-rc.d
printf 'exit 101\n' >> /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d

sed -i -e 's/PRIORITY=1 #(0..20)/PRIORITY=0 #(0..20)Z/g' /etc/init.d/capanalysis

# Change filesize
sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 500M/' /etc/php/7.2/cli/php.ini
sed -i -e 's/post_max_size = 8M/post_max_size = 500M/' /etc/php/7.2/cli/php.ini
sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 500M/' /etc/php/7.2/apache2/php.ini
sed -i -e 's/post_max_size = 8M/post_max_size = 500M/' /etc/php/7.2/apache2/php.ini

# Starts upp services
service postgresql restart
service apache2 restart
service capanalysis restart
tail -f /var/log/apache2/capana_access.log

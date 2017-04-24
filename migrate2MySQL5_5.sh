#ln -s /usr/lib/perl5/vendor_perl/Slim /usr/lib64/perl5/vendor_perl/Slim
#sed -e 's/skip-locking/skip-external-locking/' -e 's/default-character-set/character-set-server/' -e 's/default-collation/collation-server/' -i /usr/share/squeezecenter/MySQL/my.tt
sed -i 's/TYPE=InnoDB/ENGINE=InnoDB/' /usr/share/squeezecenter/SQL/mysql/schema_*.sql
mv /var/lib/squeezeboxserver/cache/MySQL /var/lib/squeezeboxserver/cache/MySQL-old


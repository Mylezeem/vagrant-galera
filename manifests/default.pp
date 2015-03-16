node default {
  File['/var/log/mariadb'] -> Class['::mariadbrepo'] -> Class['::mysql::server']

  file { ['/var/log/mariadb', '/etc/systemd/system/mysql.service.d'] :
    ensure => directory,
  }
 
  include ::mariadbrepo
  include ::mysql::server

  mysql_user { 'sst_user@%' :
    ensure        => present,
    password_hash => mysql_password('password') ,
  }
  mysql_grant { 'sst_user@%/*.*' :
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => 'sst_user@%',
  }

  # If we are on the galera master
  # then change the init script
  if $::hostname == 'mysql01' {
    exec { 'add --wsrep-new-cluster' :
      command => '/bin/sed -i \'319s/--pid-file/--wsrep-new-cluster --pid-file/g\' /etc/init.d/mysql',
      require => Package['mysql-server'],
      before  => Service['mysqld'],
    }
 }

# The following section would apply when MariaDB official packages
# would distribute systemd unit files
# ----------------------------------------------------------------
#
#  file { '/etc/systemd/system/mysql.service.d/extra.conf' :
#    ensure => present,
#    content => "
#[Service]
#ExecStart=/usr/bin/mysqld_safe --basedir=/usr --wsrep-new-cluster
#",
#    before => File['/usr/lib/systemd/system/mysql.service'],
#  }
#
#  file { '/usr/lib/systemd/system/mysql.service' :
#    ensure  => present,
#    content => "
## It's not recommended to modify this file in-place, because it will be
## overwritten during package upgrades.  If you want to customize, the
## best way is to create a file \"/etc/systemd/system/mariadb.service\",
## containing
##       .include /lib/systemd/system/mariadb.service
##       ...make your changes here...
## or create a file \"/etc/systemd/system/mariadb.service.d/foo.conf\",
## which doesn't need to include \".include\" call and which will be parsed
## after the file mariadb.service itself is parsed.
##
## For more info about custom unit files, see systemd.unit(5) or
## http://fedoraproject.org/wiki/Systemd#How_do_I_customize_a_unit_file.2F_add_a_custom_unit_file.3F
## For example, if you want to increase mysql's open-files-limit to 10000,
## you need to increase systemd's LimitNOFILE setting, so create a file named
## \"/etc/systemd/system/mariadb.service.d/limits.conf\" containing:
##       [Service]
##       LimitNOFILE=10000
## Note: /usr/lib/... is recommended in the .include line though /lib/... 
## still works.
## Don't forget to reload systemd daemon after you change unit configuration:
## root> systemctl --system daemon-reload
#[Unit]
#Description=MariaDB database server
#After=syslog.target
#After=network.target
#[Service]
#Type=simple
#User=mysql
#Group=mysql
#ExecStartPre=/usr/libexec/mariadb-prepare-db-dir %n
## Note: we set --basedir to prevent probes that might trigger SELinux alarms,
## per bug #547485
#ExecStart=/usr/bin/mysqld_safe --basedir=/usr
#ExecStartPost=/usr/libexec/mariadb-wait-ready \$MAINPID
## Give a reasonable amount of time for the server to start up/shut down
#TimeoutSec=30
## Place temp files in a secure directory, not /tmp
#PrivateTmp=true
#[Install]
#WantedBy=multi-user.target
#    ",
#    before => Exec['/bin/systemctl daemon-reload'],
#  }
#
#  exec { '/bin/systemctl daemon-reload' :
#    before => Service['mysqld'],
#  }

}

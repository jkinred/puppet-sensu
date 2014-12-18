class sensu::client(
  $subscriptions = ['default']
  $mq_port = 5672,
  $mq_host = "sensu",
  $mq_user = "sensu",
  $mq_password "sensu",
  $mq_vhost = "/"
) {
  package { 'sensu': ensure => installed }
  package { 'nagios-plugins': ensure => installed }

  file { '/etc/sensu/config.json':
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => template('sensu/config.json.erb'),
  }

  file { '/etc/sensu/conf.d/client.json':
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => template('sensu/client.json.erb'),
  }
}

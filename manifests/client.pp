class sensu::client(
  $subscriptions = ['default']
  $mq_port = 5672,
  $mq_host = "sensu",
  $mq_user = "sensu",
  $mq_password "sensu",
  $mq_vhost = "/"
) {
  apt::source { 'sensu':
    location   => "http://repos.sensuapp.org/apt",
    repos      => "main",
    key        => "7580C77F",
    key_source => "http://repos.sensuapp.org/apt/pubkey.gpg",
  }

  package { ['sensu']:
    ensure  => installed,
    require => Apt::Source['sensu']
  }

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

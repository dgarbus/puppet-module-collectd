# https://collectd.org/wiki/index.php/Plugin:Redis
class collectd::plugin::redis (
  $ensure      = 'present',
  $nodes       = { 'redis' => {
      'host'    => 'localhost',
      'port'    => '6379',
      'timeout' => 2000,
    }
  },
) {

  validate_hash($nodes)

  if $::osfamily == 'Redhat' {
    package { 'collectd-redis':
      ensure => installed
    }
  }

  collectd::plugin {'redis':
    ensure  => $ensure,
    content => template('collectd/plugin/redis.conf.erb'),
  }
}

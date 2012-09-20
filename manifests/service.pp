# Class god::service
# 
# Setup upstart script and control god service
#
# == Parameters
#
#
# == Examples
#
#
# == Requires:
#
#   class { god::install: }
#   class { god::master::config }
#
# This class file is not called directly
class god::service {

  if $god::service_provider == 'upstart' {
    File['god_upstart'] -> Service['god']

    file { 'god_upstart':
      ensure => $god::ensure,
      path   => '/etc/init/god.conf',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      content => template('god/god.conf.erb'),
    }
  }

  service { 'god':
    ensure   => $god::ensure_service,
    provider => $god::service_provider,
  }

}

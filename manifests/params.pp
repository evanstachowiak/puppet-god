# Class god::params
# 
# All conf settings for candiapp class
#
# == Parameters
#
#
#
# == Examples
#
#
# == Requires:
#
class god::params {

  case $::operatingsystem {
    /(?i-mx:debian|ubuntu)/: {
      $use_rvm           = 'true'
      $rvm_bin           = '/usr/local/rvm/bin/rvm'
      $rvm_gem_path      = '/usr/local/rvm/gems'
      $rvm_gemset        = 'global'
      $god_master_erb    = 'master.god.erb'
      $god_conf_path     = '/etc/god'
      $god_master_conf   = "${god_conf_path}/master.god"
      $god_conf_d        = "${god_conf_path}/conf.d"
      $god_conf_owner    = 'root'
      $god_conf_group    = 'root'
      $god_conf_dir_mode = '2755'
      $god_conf_mode     = '0644'
      $service_provider  = 'upstart'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

}

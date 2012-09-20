# Class god
# 
# Install god process monitring daemon and config
#
# == Parameters
#
#   [*use_rvm*]
#     Sets whether rvm is used. Defaults to true.
#   [*ruby_version*]
#     Ruby version that god will use.
#
# == Examples
#
#
# == Requires:
#
#   If use_rvm = 'true':
#   include rvm
#
class god (
  $ensure            = 'present',
  $ensure_service    = 'running',
  $service_provider  = $god::params::service_provider,
  $use_rvm           = $god::params::use_rvm,
  $rvm_gemset        = $god::params::rvm_gemset,
  $package_provider  = $god::params::package_provider,
  $god_master_conf   = $god::params::god_master_conf,
  $god_master_erb    = $god::params::god_master_erb,
  $god_conf_path     = $god::params::god_conf_path,
  $god_conf_owner    = $god::params::god_conf_owner,
  $god_conf_group    = $god::params::god_conf_group,
  $god_conf_dir_mode = $god::params::god_conf_dir_mode,
  $god_conf_mode     = $god::params::god_conf_mode,
  $ruby_version
) inherits god::params {

  Class['god'] -> Class['god::master::config'] ~> Class['god::service']
  include god::master::config
  include god::service

  if $use_rvm == 'true' {
    Rvm_system_ruby[$ruby_version] -> Class['god']

    Rvm_gem['god'] -> Exec['create_god_wrapper']
    # Install god with correct RVM
    rvm_gem { 'god':
        ensure       => $ensure,
        ruby_version => "${ruby_version}@${rvm_gemset}",
     }

    # Create rvm wrapper class for god
    exec { 'create_god_wrapper':
      command => "${rvm_path}/bin/rvm wrapper ${ruby_version}@${rvm_gemset} ruby ${rvm_path}/gems/${ruby_version}/bin/god",
      creates => "${rvm_path}/bin/ruby_god",
    }
      
  }
  else {
    package { 'god':
      ensure   => $ensure,
      provider => $package_provider,
    }
  }

}

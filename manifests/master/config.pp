# Class god::master::config
# 
# Master config for god
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
#   class { 'god': }
#
# This class file is not called directly
class god::master::config {

  $ensure_dir = $god::ensure ? { 'present' => 'directory', default => $god::ensure }

  file { $god::god_conf_path:
    ensure => $ensure_dir,
    force  => 'true',
    purge  => 'true',
    owner  => $god::god_conf_owner,
    group  => $god::god_conf_group,
    mode   => $god::god_conf_mode,
  }

  file { $god::god_master_conf:
    ensure  => $god::ensure,
    owner   => $god::god_conf_owner,
    group   => $god::god_conf_group,
    mode    => $god::god_conf_dir_mode,
    content => template("god/$god_master_erb"),
  }

  file { $god::god_conf_d:
    ensure => $ensure_dir,
    force  => 'true',
    purge  => 'true',
    owner  => $god::god_conf_owner,
    group  => $god::god_conf_group,
    mode   => $god::god_conf_mode,
  }

}

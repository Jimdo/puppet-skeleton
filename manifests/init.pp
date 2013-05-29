# Install/configure something here
class skeleton(
  $command = '/bin/true',
  $package = 'tree'
){
  # Replace this with meaningful resources
  exec { 'sample_command': command => $command }
  package { 'sample_package': name => $package, ensure => installed }
}

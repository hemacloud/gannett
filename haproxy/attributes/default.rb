
# Cookbook Name:: haproxy

default['haproxy']['yum']['package']['version'] = '1.5.4-3.el6'

# necessary packages to build Nginx as well as extra Nginx modules.

default['package']['supported_packages'] = %w(make gcc pcre-static pcre-devel)
# package version
default['package_version'] = '1.6.3'
# package download link

default['package']['url'] = 'http://www.haproxy.org/download/1.6/src/haproxy-1.6.3.tar.gz'
# installation and configuration
default['package']['user'] = 'haproxy'
default['package']['group'] = 'haproxy'
default['package']['dir'] = '/etc/init.d/'
default['package']['script'] = "#{node['package']['dir']}/haproxy"
default['package']['conf']['dir'] = '/etc/haproxy/'
default['package']['conf'] = "#{node['package']['conf']['dir']}/haproxy"
# loadblancer backend configration
default['backend']['port'] = '80'
default['haproxy']['incoming_port'] = '80'
default['haproxy']['balance_algorithm'] = 'roundrobin'
default['haproxy']['backend'] = 'google.com'

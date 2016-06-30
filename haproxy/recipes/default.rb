#
# Cookbook Name:: haproxy
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'haproxy' do
  retries 3
  retry_delay 5

  action :install
end
template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[haproxy]'
end
service 'haproxy' do
  action [:enable, :start]
end

#
# Cookbook Name:: haproxy
# Recipe:: haproxy_yum
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'haproxy' do
  version node['haproxy']['yum']['package']['version']
  action :install
end
template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[haproxy]'
end
service 'haproxy' do
  supports restart: true, status: true, reload: true
  action [:enable, :start]
end

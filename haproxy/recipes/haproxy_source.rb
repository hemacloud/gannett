#
# Cookbook Name:: haproxy
# Recipe:: haproxy_source
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

user 'haproxy' do
  comment 'haproxy system account'
  system true
  shell '/bin/false'
end

node['package']['supported_packages'].each do |pkg|
  package pkg do
    action :install
  end
end
haproxy '1.6.3' do
  action :install
  source 'http://www.haproxy.org/download/1.6/src/haproxy-1.6.3.tar.gz'
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

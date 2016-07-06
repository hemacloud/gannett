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
remote_file "#{Chef::Config['file_cache_path']}/haproxy-#{node['package_version']}.tar.gz" do
  source node['package']['url'].to_s
  mode '0644'
  action :create
end
# bash
bash 'install_program' do
  user 'root'
  cwd Chef::Config[:file_cache_path].to_s
  code <<-EOH
    tar xzf "#{Chef::Config['file_cache_path']}/haproxy-#{node['package_version']}.tar.gz"
    cd "#{Chef::Config['file_cache_path']}/haproxy-#{node['package_version']}"
    make TARGET=linux2628
    make install
    cp /usr/local/sbin/haproxy /usr/sbin/
    cp "#{Chef::Config['file_cache_path']}/haproxy-#{node['package_version']}/examples/haproxy.init" /etc/init.d/haproxy
    chmod 755 /etc/init.d/haproxy
    mkdir -p /etc/haproxy
    mkdir -p /run/haproxy
    mkdir -p /var/lib/haproxy
    touch /var/lib/haproxy/stats
 EOH
  action :run
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

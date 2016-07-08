
# Cookbook Name:: haproxy
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'haproxy::haproxy_source'
# include_recipe 'haproxy::haproxy_yum'
# case node['instlation']
# when 'source'
# do things on debian-ish platforms (debian, ubuntu, linuxmint)
# when 'yum'
# end

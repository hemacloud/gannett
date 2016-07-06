#
# Cookbook Name:: haproxy
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'haproxy::haproxy_source' do
  context 'when run on CentOS 6.7' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'installs make' do
      expect(chef_run).to install_package 'make'
    end
    it 'installs gcc' do
      expect(chef_run).to install_package 'gcc'
    end
    it 'installs pcre-static' do
      expect(chef_run).to install_package 'pcre-static'
    end
    it 'installs pcre-devel' do
      expect(chef_run).to install_package 'pcre-devel'
    end
    it 'downloads pakage source code tar' do
      expect(chef_run).to create_remote_file "#{Chef::Config[:file_cache_path]}/haproxy-1.6.3.tar.gz"
    end

    it 'enables the haproxy service' do
      expect(chef_run).to enable_service 'haproxy'
    end

    it 'starts the haproxy servic' do
      expect(chef_run).to start_service 'haproxy'
    end
    it 'creates the haproxy conf ' do
      expect(chef_run).to create_template('/etc/haproxy/haproxy.cfg').with(
        source: 'haproxy.cfg.erb',
        owner: 'root',
        group: 'root',
        mode: '0644'
      )
    end
  end
end

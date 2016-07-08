#
# Cookbook Name:: haproxy
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'haproxy::haproxy_source' do
  context 'when run on CentOS 6.7' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(step_into: ['haproxy'])
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
    it 'installs coustom resource' do
      expect(chef_run).to install_haproxy '1.6.3'
    end

    it 'downloads package source code tar' do
      expect(chef_run).to create_remote_file "#{Chef::Config[:file_cache_path]}/haproxy-1.6.3.tar.gz"
    end
    it 'downloads package source code tar' do
      expect(chef_run).to create_remote_file "#{Chef::Config[:file_cache_path]}/haproxy-1.6.3.tar.gz"
    end
    it 'unzip tar file' do
      resource = chef_run.remote_file "#{Chef::Config[:file_cache_path]}/haproxy-1.6.3.tar.gz"
      expect(resource).to notify('execute[unzip_archive]').to(:run).immediately
      #      expect(chef_run).to run_execute('unzip_archive')
    end
    it 'install the haproxy from source' do
      resource = chef_run.execute('unzip_archive')
      expect(resource).to notify('execute[install_haproxy]').to(:run).immediately
    end

    it 'configure haproxy' do
      resource = chef_run.execute('install_haproxy')
      expect(resource).to notify('bash[configure]').to(:run).immediately
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

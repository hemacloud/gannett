#
# Cookbook Name:: haproxy
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'haproxy::haproxy_yum' do
  context 'when run on CentOS 7.2.1511' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs haproxy' do
      expect(chef_run).to install_package 'haproxy'
    end

    it 'enables the haproxy service' do
      expect(chef_run).to enable_service 'haproxy'
    end

    it 'starts the haproxy service' do
      expect(chef_run).to start_service 'haproxy'
    end
  end
end
